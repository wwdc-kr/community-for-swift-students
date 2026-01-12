import SwiftUI

struct UnavailableView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundStyle(.secondary)
            
            VStack(spacing: 12) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(message)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
}
