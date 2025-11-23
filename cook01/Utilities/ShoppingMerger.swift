import Foundation

enum ShoppingMerger {
    static func merge(
        recipeItems: [RecipeShoppingItems],
        selectedIDs: Set<String>,
        states: [Int: Bool]
    ) -> [ShoppingItem] {
        var map: [String: ShoppingItem] = [:]

        recipeItems
            .filter { selectedIDs.contains($0.recipeId) }
            .forEach { recipe in
                recipe.items.forEach { item in
                    let key = "\(item.name)-\(item.category.rawValue)"
                    if var existing = map[key] {
                        if !existing.amounts.contains(item.amount) {
                            existing.amounts.append(item.amount)
                        }
                        if !existing.recipes.contains(recipe.recipeName) {
                            existing.recipes.append(recipe.recipeName)
                        }
                        existing.checked = states[item.id] ?? existing.checked
                        map[key] = existing
                    } else {
                        map[key] = ShoppingItem(
                            id: item.id,
                            name: item.name,
                            amounts: [item.amount],
                            category: item.category,
                            checked: states[item.id] ?? false,
                            recipes: [recipe.recipeName]
                        )
                    }
                }
            }

        return map
            .values
            .sorted { lhs, rhs in
                if lhs.category.rawValue == rhs.category.rawValue {
                    return lhs.name < rhs.name
                }
                return lhs.category.rawValue < rhs.category.rawValue
            }
    }
}

