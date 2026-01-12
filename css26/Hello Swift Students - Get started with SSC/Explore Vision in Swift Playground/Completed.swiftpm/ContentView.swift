import SwiftUI
import Vision

struct ContentView: View {
    
    let camera = Camera()
    
    @State private var image: Image?
    
    @State private var leftWrist: CGPoint?
    @State private var rightWrist: CGPoint?
    
    @State private var size: CGSize = .zero
    
    @State private var target: TargetLocation = .random()
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            Group {
                if let image {
                    ZStack(alignment: .topLeading) {
                        Color.black
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .onGeometryChange(for: CGSize.self) { proxy in
                                proxy.size
                            } action: { newValue in
                                size = newValue
                            }
                            .opacity(0.3)
                        
                        if let leftWrist {
                            Circle()
                                .fill(.blue)
                                .frame(width: 20, height: 20)
                                .position(leftWrist)
                        }
                        
                        if let rightWrist {
                            Circle()
                                .fill(.red)
                                .frame(width: 20, height: 20)
                                .position(rightWrist)
                        }
                        
                        Path { path in
                            path.addRect(CGRect(x: CGFloat(target.x) * size.width / 3,
                                                y: CGFloat(target.y) * size.height / 5,
                                                width: size.width / 3,
                                                height: size.height / 5))
                        }
                        .fill(target.isLeftHand ? .blue : .red)
                        .opacity(0.5)
                    }
                } else {
                    ProgressView()
                }
            }
            
            VStack {
                Text("\(score)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .monospacedDigit()
                    .contentTransition(.numericText(value: Double(score)))
                
                Spacer()
                
                Button("Reset") {
                    withAnimation {
                        score = 0
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .task {
            await camera.start()
            
            for await preview in camera.previewStream {
                self.image = preview.image
                
                Task {
                    guard let result = await performVisionRequest(on: preview) else { return }
                    
                    leftWrist = result.allJoints()[.leftWrist]?.location.toImageCoordinates(size, origin: .upperLeft)
                    rightWrist = result.allJoints()[.rightWrist]?.location.toImageCoordinates(size, origin: .upperLeft)
                    
                    if isWristOnTargetTile() {
                        target = .random()
                        withAnimation {
                            score += 1
                        }
                    }
                }
            }
        }
    }
    
    func performVisionRequest(on image: CIImage) async -> HumanBodyPoseObservation? {
        let request = DetectHumanBodyPoseRequest()
        let results = try! await request.perform(on: image)
        
        return results.first
    }
    
    func isWristOnTargetTile() -> Bool {
        let wrist: CGPoint?
        
        if target.isLeftHand {
            wrist = leftWrist
        } else {
            wrist = rightWrist
        }
        
        guard let wrist else { return false }
        
        let x = Int(wrist.x / (size.width / 3))
        let y = Int(wrist.y / (size.height / 5))
        
        return target.x == x && target.y == y
    }
}
