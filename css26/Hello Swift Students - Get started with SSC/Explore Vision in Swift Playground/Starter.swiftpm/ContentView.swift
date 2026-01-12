import SwiftUI

struct ContentView: View {
    
    let camera = Camera()
    
    @State private var image: Image?
    
    var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .task {
            await camera.start()
            
            for await preview in camera.previewStream {
                self.image = preview.image
            }
        }
    }
}
