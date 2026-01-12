import SwiftUI
import ARKit
import RealityKit

struct ARImageTrackingView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        arView.session.delegate = context.coordinator
        context.coordinator.arView = arView
        
        guard let image = UIImage(named: "Logo")?.cgImage 
        else {
            fatalError("❌ AR Resources not found")
        } 
      
        let referenceImage = ARReferenceImage(image, orientation: .up, physicalWidth: 0.1)
        
        let config = ARWorldTrackingConfiguration()
        
        //Mission - People Occlusion 적용
        config.detectionImages = [referenceImage]
        config.maximumNumberOfTrackedImages = 1
        
        arView.session.run(config)

        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, ARSessionDelegate {
        
        weak var arView: ARView?
        
        func session(
            _ session: ARSession,
            didAdd anchors: [ARAnchor]
        ) {
            guard let arView else { return }
                        
            for anchor in anchors {
                guard let imageAnchor = anchor as? ARImageAnchor else { continue }
                
                let size = Float(imageAnchor.referenceImage.physicalSize.width) * 0.07
                
                let textMesh = MeshResource.generateText("Hello \nfuture\nwinners!", extrusionDepth: 10.0)
                
                let textEntity = ModelEntity(
                    mesh: textMesh,
                    materials: [
                        SimpleMaterial(
                            color: .orange,
                            isMetallic: false
                        )
                    ]
                )
                
                let anchorEntity = AnchorEntity(anchor: imageAnchor)
                textEntity.scale = [size, size, size]
                textEntity.position = [-0.2, -0.6, 0.1]
                textEntity.components.set(BillboardComponent())
                
                anchorEntity.addChild(textEntity)
                arView.scene.addAnchor(anchorEntity)
            }
        }
    }
}

