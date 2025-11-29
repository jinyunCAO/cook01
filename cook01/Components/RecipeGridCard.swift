import SwiftUI

// 网格布局的食谱卡片（用于首页）
struct RecipeGridCard: View {
    let recipe: Recipe
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: UIStyle.RecipeGridCard.cardSpacing) {
                // 圆形图片
                AsyncImage(url: recipe.imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_), .empty:
                        Circle()
                            .fill(Color.gray200)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.title2)
                                    .foregroundStyle(Color.gray400)
                            )
                    @unknown default:
                        Circle()
                            .fill(Color.gray200)
                    }
                }
                .frame(width: UIStyle.RecipeGridCard.imageSize, height: UIStyle.RecipeGridCard.imageSize)
                .clipShape(Circle())
                
                // 菜谱名称
                Text(recipe.name)
                    .font(.system(size: UIStyle.RecipeGridCard.nameFontSize, weight: .medium))
                    .foregroundStyle(Color.gray800)
                    .lineLimit(1)
                
                // 时间
                HStack(spacing: UIStyle.RecipeGridCard.timeSpacing) {
                    Image(systemName: "clock")
                        .font(.system(size: UIStyle.RecipeGridCard.timeIconSize))
                        .foregroundStyle(Color.gray500)
                    Text(recipe.time)
                        .font(.system(size: UIStyle.RecipeGridCard.timeFontSize))
                        .foregroundStyle(Color.gray500)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, UIStyle.RecipeGridCard.paddingTop)
            .padding(.bottom, UIStyle.RecipeGridCard.paddingBottom)
            .padding(.horizontal, UIStyle.RecipeGridCard.paddingHorizontal)
            .background(Color.gray200.opacity(UIStyle.RecipeGridCard.backgroundOpacity))
            .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

