import SwiftUI

struct IngredientGroup: View {
    let category: String
    let items: [Ingredient]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(category)
                .font(.headline)
                .foregroundStyle(Color.orange600)

            VStack(spacing: 10) {
                ForEach(items) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .foregroundStyle(Color.gray700)
                        Spacer()
                        Text(ingredient.amount)
                            .foregroundStyle(Color.orange600)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.orange50)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }
}

