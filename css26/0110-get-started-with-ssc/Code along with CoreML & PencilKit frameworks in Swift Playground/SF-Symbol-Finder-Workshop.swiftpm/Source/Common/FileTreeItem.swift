import SwiftUI

struct FileTreeItem: View {
    let icon: String
    let name: String
    let color: Color
    let level: Int
    var comment: String? = nil

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 16)

            Text(name)
                .foregroundColor(color)

            if let comment = comment {
                Text(comment)
                    .foregroundColor(.secondary)
                    .font(.system(.caption, design: .monospaced))
            }

            Spacer()
        }
        .padding(.leading, CGFloat(level * 30))
    }
}
