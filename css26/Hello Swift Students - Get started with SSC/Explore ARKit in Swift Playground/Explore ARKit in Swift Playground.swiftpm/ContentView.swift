import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Mission - 얼굴 인식 부위 바꾸기
            FaceTrackingTabView()
                .tabItem {
                    Label("Face", systemImage: "face.smiling")
                }
            
            // Mission - 다른 평면 값 추가해보기
            PlaneDetectionTabView()
                .tabItem {
                    Label("Plane", systemImage: "cube")
                }
            
            // Mission - 글자 증강 확인해보기, People Occlusion 추가
            ImageTrackingTabView()
                .tabItem {
                    Label("Image", systemImage: "photo")
                }
            
            // Mission - 공간 전체를 Mesh
            SceneReconstructionTabView()
                .tabItem {
                    Label("Reconstruct", systemImage: "square.3.layers.3d")
                }
        }
    }
}
