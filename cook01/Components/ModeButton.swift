import SwiftUI

struct ModeButton: View {
    let title: String
    let systemImage: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: UIStyle.Spacing.sm) {
                Image(systemName: systemImage)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(selected ? Color.white : Color.gray600)
            .frame(maxWidth: .infinity)
            .padding(.vertical, UIStyle.Spacing.md)
            .background(selected ? Color.orange500 : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                    .stroke(selected ? Color.clear : Color.gray300, lineWidth: UIStyle.Border.width)
            )
        }
        .buttonStyle(.plain)
    }
}

