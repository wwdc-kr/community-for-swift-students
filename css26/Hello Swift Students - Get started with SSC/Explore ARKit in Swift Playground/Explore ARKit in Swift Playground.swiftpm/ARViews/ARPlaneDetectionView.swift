import SwiftUI
import RealityKit
import ARKit

struct ARPlaneDetectionView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let view = ARView(frame: .zero)
        context.coordinator.view = view
        
        let config = ARWorldTrackingConfiguration()
        //Mission - 세로 벽도 인식되게 만들기
        config.planeDetection = [.horizontal]
        view.session.run(config)
        
        let tap = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        view.addGestureRecognizer(tap)
        
        return view
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    final class Coordinator: NSObject {
        weak var view: ARView?
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let view else { return }
            let location = gesture.location(in: view)
            
            if let result = view.raycast(
                from: location,
                allowing: .estimatedPlane,
                alignment: .any
            ).first {
                
                // Mission - 크기 바꿔보기
                let cube = ModelEntity(
                    mesh: .generateBox(size: 0.05),
                    materials: [SimpleMaterial(color: .blue, isMetallic: false)]
                )
                
                let anchor = AnchorEntity(world: result.worldTransform)
                anchor.addChild(cube)
                view.scene.addAnchor(anchor)
            }
        }
    }
}
