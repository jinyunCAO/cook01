import SwiftUI

struct IngredientGroup: View {
    let category: String
    let items: [Ingredient]

    var body: some View {
        VStack(alignment: .leading, spacing: UIStyle.Spacing.md) {
            // 分类标题（浅灰色）
            Text(category)
                .font(.headline)
                .foregroundStyle(Color.gray500)

            VStack(spacing: UIStyle.Spacing.sm + 2) {
                ForEach(items) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .foregroundStyle(Color.gray800)
                        Spacer()
                        Text(ingredient.amount)
                            .foregroundStyle(Color.gray600)
                    }
                    .padding(.horizontal, UIStyle.Padding.md + 2)
                    .padding(.vertical, UIStyle.Spacing.sm + 2)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

