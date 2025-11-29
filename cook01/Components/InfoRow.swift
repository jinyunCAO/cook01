import SwiftUI

struct InfoRow: View {
    let icon: String
    let text: String
    let tint: Color

    var body: some View {
        HStack(spacing: UIStyle.Spacing.xs + 2) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(tint)
            Text(text)
                .font(.caption)
                .foregroundStyle(tint)
        }
        .padding(.horizontal, UIStyle.Spacing.sm + 2)
        .padding(.vertical, UIStyle.Spacing.xs + 2)
        .background(tint.opacity(0.15))
        .clipShape(Capsule())
    }
}

