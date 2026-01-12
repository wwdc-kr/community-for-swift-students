import SwiftUI
import RealityKit
import ARKit

struct ARFaceTrackingView: UIViewRepresentable {
    
    let faceState: FaceState
    
    func makeUIView(context: Context) -> ARView {
        //MARK: ARView 생성
        let view = ARView(frame: .zero)
        view.session.delegate = context.coordinator
        context.coordinator.faceState = faceState
        
        //MARK: 어떤 기능을 이용할지 설정
        let config = ARFaceTrackingConfiguration()
        
        //MARK: AR Session 시작
        view.session.run(config)
        
        return view
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    final class Coordinator: NSObject, ARSessionDelegate {
        var faceState: FaceState?
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let face = anchor as? ARFaceAnchor else { continue }
                
                let blend = face.blendShapes
                // Mission - 오른쪽 눈으로 바꿔보기
                let eye =
                (blend[.eyeBlinkLeft]?.floatValue ?? 0) > 0.5
                
                let mouth =
                (blend[.jawOpen]?.floatValue ?? 0) > 0.3
                
                DispatchQueue.main.async {
                    self.faceState?.isEyeClosed = eye
                    self.faceState?.isMouthOpen = mouth
                }
            }
        }
    }
}
