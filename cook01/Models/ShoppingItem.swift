import Foundation

struct RecipeShoppingItems {
    let recipeId: String
    let recipeName: String
    var items: [RawShoppingItem]
}

struct RawShoppingItem {
    let id: Int
    let name: String
    let amount: String
    let category: IngredientCategory
}

struct ShoppingItem: Identifiable {
    let id: Int
    let name: String
    var amounts: [String]
    let category: IngredientCategory
    var checked: Bool
    var recipes: [String]

    var joinedAmounts: String {
        amounts.joined(separator: " + ")
    }

    func withToggled() -> ShoppingItem {
        var copy = self
        copy.checked.toggle()
        return copy
    }

    func withChecked(_ newValue: Bool) -> ShoppingItem {
        var copy = self
        copy.checked = newValue
        return copy
    }
}

