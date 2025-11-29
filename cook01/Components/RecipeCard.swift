import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    var isSelected: Bool = false
    var showCheckbox: Bool = false
    var onTap: (() -> Void)?
    var onDetailTap: (() -> Void)?

    var body: some View {
        HStack(alignment: .top, spacing: UIStyle.Spacing.lg) {
            // 多选按钮（只在多选模式下显示）
            if showCheckbox {
        Button {
            onTap?()
                } label: {
                    ZStack {
                        Circle()
                            .fill(isSelected ? Color.orange500 : Color.white)
                            .frame(width: UIStyle.Button.iconSizeSmall, height: UIStyle.Button.iconSizeSmall)
                            .overlay(
                                Circle()
                                    .stroke(isSelected ? Color.orange500 : Color.gray300, lineWidth: UIStyle.Border.widthThick)
                            )
                        
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: UIStyle.FontSize.caption, weight: .bold))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            
            // 菜谱内容（点击查看详情）
            Button {
                onDetailTap?()
        } label: {
            HStack(alignment: .top, spacing: UIStyle.Spacing.lg) {
                AsyncImage(url: recipe.imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Color.orange100
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.title)
                                    .foregroundStyle(Color.orange400)
                            )
                    case .empty:
                        ProgressView()
                    @unknown default:
                        Color.orange100
                    }
                }
                .frame(width: 96, height: 96)
                    .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
                .overlay(
                        RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                            .stroke(Color.gray300, lineWidth: UIStyle.Border.width)
                )

                VStack(alignment: .leading, spacing: UIStyle.Spacing.sm) {
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundStyle(Color.gray800)

                    HStack(spacing: UIStyle.Spacing.xs + 2) {
                        ForEach(recipe.tags.prefix(3), id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, UIStyle.Spacing.sm)
                                .padding(.vertical, UIStyle.Spacing.xs)
                                .background(Color.orange100)
                                .foregroundStyle(Color.orange600)
                                .clipShape(Capsule())
                        }
                    }

                    HStack(spacing: UIStyle.Spacing.md) {
                        Label(recipe.time, systemImage: "clock")
                            .font(.caption)
                            .foregroundStyle(Color.gray500)
                        Text("·")
                            .foregroundStyle(Color.gray400)
                        Text(recipe.difficulty)
                            .font(.caption)
                            .foregroundStyle(Color.gray500)
                    }
                }

                Spacer()
            }
            .padding(UIStyle.Padding.lg)
                .background(isSelected ? Color.orange50 : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
            .overlay(
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                        .stroke(isSelected ? Color.orange500 : Color.gray300, lineWidth: isSelected ? UIStyle.Border.widthThick : UIStyle.Border.width)
            )
        }
        .buttonStyle(.plain)
        }
    }
}

