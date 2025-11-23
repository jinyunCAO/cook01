import SwiftUI

struct ModeButton: View {
    let title: String
    let systemImage: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(selected ? Color.white : Color.gray600)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(selected ? Color.orange500 : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(selected ? Color.clear : Color.gray300, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

