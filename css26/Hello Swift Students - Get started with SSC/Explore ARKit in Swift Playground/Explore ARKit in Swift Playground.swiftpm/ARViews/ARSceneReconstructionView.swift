import SwiftUI
import ARKit
import SceneKit

struct ARSceneReconstructionView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARSCNView {
        guard ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) else {
            print("Scene Reconstruction 미 지원 기기")
            return ARSCNView(frame: .zero)
        }
        
        //MARK: ARView와 유사한 ARSCNView
        let view = ARSCNView(frame: .zero)
        view.delegate = context.coordinator
        view.scene = SCNScene()
                
        let config = ARWorldTrackingConfiguration()
        config.sceneReconstruction = .meshWithClassification
        config.environmentTexturing = .automatic
        
        view.debugOptions = [.showWireframe]
        view.session.run(config)
        
        return view
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // MARK: - Coordinator
    final class Coordinator: NSObject, ARSCNViewDelegate {
        
        func renderer(
            _ renderer: SCNSceneRenderer,
            didAdd node: SCNNode,
            for anchor: ARAnchor
        ) {
            updateMeshNode(node: node, anchor: anchor)
        }
        
        func renderer(
            _ renderer: SCNSceneRenderer,
            didUpdate node: SCNNode,
            for anchor: ARAnchor
        ) {
            updateMeshNode(node: node, anchor: anchor)
        }
        
        private func updateMeshNode(
            node: SCNNode,
            anchor: ARAnchor
        ) {
            guard let meshAnchor = anchor as? ARMeshAnchor else { return }
            
            let geometry = SCNGeometry.from(mesh: meshAnchor.geometry)
            
            geometry.materials = [
                material(for: meshAnchor)
            ]
            
            node.geometry = geometry
        }
        
        private func material(
            for anchor: ARMeshAnchor
        ) -> SCNMaterial {
            
            let material = SCNMaterial()
            material.diffuse.contents = color(for: anchor)
            
            material.transparency = 0.6
            material.isDoubleSided = true
            
            return material
        }
        
        private func color(
            for anchor: ARMeshAnchor
        ) -> UIColor {
            let classification =
                    anchor.geometry.classificationOf(faceWithIndex: 0)
            
            switch classification {
            case .floor:
                return .blue
            case .wall:
                return .green
            case .table:
                return .yellow
            case .seat:
                return .orange
            case .ceiling:
                return .purple
            default:
                return .lightGray
            }
        }
    }
}

extension ARMeshGeometry {
    func classificationOf(faceWithIndex index: Int) -> ARMeshClassification {
        guard let classification = classification else { return .none }
        assert(classification.format == MTLVertexFormat.uchar, "Expected one unsigned char (one byte) per classification")
        let classificationPointer = classification.buffer.contents().advanced(by: classification.offset + (classification.stride * index))
        let classificationValue = Int(classificationPointer.assumingMemoryBound(to: CUnsignedChar.self).pointee)
        return ARMeshClassification(rawValue: classificationValue) ?? .none
    }
}

extension SCNGeometry {
    
    static func from(mesh: ARMeshGeometry) -> SCNGeometry {
        
        // Vertices
        let vertices = mesh.vertices
        let vertexSource = SCNGeometrySource(
            buffer: vertices.buffer,
            vertexFormat: .float3,
            semantic: .vertex,
            vertexCount: vertices.count,
            dataOffset: vertices.offset,
            dataStride: vertices.stride
        )
        
        // Normals
        let normals = mesh.normals
        let normalSource = SCNGeometrySource(
            buffer: normals.buffer,
            vertexFormat: .float3,
            semantic: .normal,
            vertexCount: normals.count,
            dataOffset: normals.offset,
            dataStride: normals.stride
        )
        
        // Faces (Triangles)
        let faces = mesh.faces
        let element = SCNGeometryElement(
            buffer: faces.buffer,
            primitiveType: .triangles,
            primitiveCount: faces.count,
            bytesPerIndex: faces.bytesPerIndex
        )
        
        return SCNGeometry(
            sources: [vertexSource, normalSource],
            elements: [element]
        )
    }
}
