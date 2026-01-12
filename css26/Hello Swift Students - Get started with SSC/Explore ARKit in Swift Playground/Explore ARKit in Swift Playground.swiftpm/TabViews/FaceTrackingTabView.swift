import SwiftUI

@Observable
final class FaceState {
    var isEyeClosed = false
    var isMouthOpen = false
}

struct FaceTrackingTabView: View {
    
    @State private var faceState = FaceState()
    
    var body: some View {
        ZStack {
            ARFaceTrackingView(faceState: faceState)
                .ignoresSafeArea()
            
            VStack {
                Text(faceState.isEyeClosed ? "🙈" : "👀")
                    .font(.system(size: 100))
                
                Spacer()
                
                Text(faceState.isMouthOpen ? "😮" : "😄")
                    .font(.system(size: 100))
            }
            .padding(.vertical, 80)
        }
    }
}
