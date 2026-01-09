import SwiftUI

struct MethodCard: View {
    let number: Int
    let title: String
    let description: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("\(number).")
                        .fontWeight(.bold)
                    Text(title)
                        .fontWeight(.semibold)
                }
                Text(description)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing)
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(10)
    }
}
