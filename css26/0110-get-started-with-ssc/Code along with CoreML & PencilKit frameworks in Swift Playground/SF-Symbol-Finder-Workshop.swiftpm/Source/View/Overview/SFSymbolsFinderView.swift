import SwiftUI
import PencilKit
import CoreML
import Vision

struct SFSymbolFinderView: View {
    @State private var results = [ClassificationResult]()
    private let canvasView = CanvasRepresentingView()
    private let symbols = [
        "helm", "lasso", "rays", "loupe", "swirl.circle.righthalf.filled",
        "fleuron", "skew", "glowplug", "dpad", "megaphone",
        "pano", "viewfinder", "seal", "chevron.left.forwardslash.chevron.right", "suit.club"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                sfSymbolsView
                Divider()
                imageView(name: "Episode ①")
                Divider()
                imageView(name: "Episode ②")
                Divider()
                sfSymbolFinderView
            }
            .padding(50)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("SF Symbols Finder")
    }
    
    private var sfSymbolsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image("sf_symbols")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("SF Symbols")
                    .font(.largeTitle)
                    .bold()
            }
            Text("SF Symbols 7은 Apple 플랫폼의 시스템 폰트와 완벽하게 통합되도록 설계된 6,900개 이상의 심볼 라이브러리입니다.")
            Text("SF Symbols 7 is a library of over 6,900 symbols designed to integrate seamlessly with San Francisco, the system font for Apple platforms. ")
                .font(.callout)
                .foregroundStyle(.gray)
            Text("""
  사용 방법
  // SwiftUI
  Image(systemName: "heart.fill")

  // UIKit
  let image = UIImage(systemName: "star.fill")
""")
            .padding()
            .background {
                Color.black
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
        }
    }
    
    private func imageView(name: String) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.title)
                .bold()
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 700)
        }
    }
    
    private var sfSymbolFinderView: some View {
        VStack(alignment: .leading, spacing: 50) {
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem(), GridItem()], spacing: 20) {
                ForEach(symbols, id: \.self) { symbolName in
                    Image(systemName: symbolName)
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 700)
            HStack(spacing: 20) {
                ZStack {
                    canvasView

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button("CLEAR") {
                                results = []
                                canvasView.clear()
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button("SEARCH") {
                                predict()
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                        }
                        .padding()
                    }
                }
                .frame(width: 500, height: 500)
                
                if !results.isEmpty {
                    VStack {
                        Text("Results")
                            .font(.title)
                            .bold()
                        ForEach(results, id: \.id) { result in
                            HStack(spacing: 20) {
                                Text(result.identifier)
                                Text("\(result.confidence)")
                            }   
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func predict() {
        let image = canvasView.getImage()
        guard
            let coreMLModel = try? SFSymbolClassifier(configuration: MLModelConfiguration()),
            let visionModel = try? VNCoreMLModel(for: coreMLModel.model)
        else {
            return
        }
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else { return }
            guard let observations = request.results as? [VNClassificationObservation] else { return }
            results = []
            let sortedObservations = observations.sorted(by: { $0.confidence > $1.confidence }).prefix(10)
            sortedObservations.forEach { observation in
                results.append(ClassificationResult(
                    identifier: observation.identifier,
                    confidence: Int(observation.confidence * 100)
                ))
            }
        }

        guard let ciImage = CIImage(image: image) else { return }
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

struct CanvasRepresentingView: UIViewRepresentable {

    var canvas = PKCanvasView()

    func makeUIView(context: Context) -> PKCanvasView {
        canvas.backgroundColor = .darkGray
        canvas.tool = PKInkingTool(.pencil, color: .black, width: 20)
        return canvas
    }

    func updateUIView(_ canvas: PKCanvasView, context: Context) { }

    func getImage() -> UIImage {
        return canvas.drawing.image(from: canvas.bounds, scale: 1.0)
    }

    func clear() {
        canvas.drawing = PKDrawing()
        canvas.setNeedsDisplay()
    }
}
