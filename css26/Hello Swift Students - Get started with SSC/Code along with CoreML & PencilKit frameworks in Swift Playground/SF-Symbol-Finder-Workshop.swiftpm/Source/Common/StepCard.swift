import SwiftUI

struct StepCard: View {
    let step: Int
    let title: String
    let description: String?
    
    init(step: Int, title: String, description: String? = nil) {
        self.step = step
        self.title = title
        self.description = description
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text("\(step)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                if let description {
                    Text(description)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
