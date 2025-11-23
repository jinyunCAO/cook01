import Foundation
import Combine

final class ShoppingListViewModel: ObservableObject {
    enum Mode { case byRecipe, merged }

    @Published var viewMode: Mode = .merged
    @Published var selectedRecipes: Set<String>
    @Published var itemStates: [Int: Bool] = [:]
    @Published var showAddForm: Bool = false
    @Published var newItemName: String = ""
    @Published var recipeItems: [RecipeShoppingItems]
    @Published var filterRecipeId: String? = nil

    private var nextItemID: Int

    init(recipeItems: [RecipeShoppingItems] = MockData.recipeItems) {
        self.recipeItems = recipeItems
        self.selectedRecipes = Set(recipeItems.map(\.recipeId))
        let maxID = recipeItems
            .flatMap { $0.items }
            .map(\.id)
            .max() ?? 100
        self.nextItemID = maxID + 1
    }

    var mergedItems: [ShoppingItem] {
        ShoppingMerger.merge(recipeItems: recipeItems, selectedIDs: selectedRecipes, states: itemStates)
    }

    var currentItems: [ShoppingItem] {
        switch viewMode {
        case .merged:
            return mergedItems
        case .byRecipe:
            let source = filteredRecipeItems
            return source.flatMap { recipe in
                recipe.items.map { item in
                    ShoppingItem(
                        id: item.id,
                        name: item.name,
                        amounts: [item.amount],
                        category: item.category,
                        checked: itemStates[item.id] ?? false,
                        recipes: [recipe.recipeName]
                    )
                }
            }
        }
    }

    var filteredRecipeItems: [RecipeShoppingItems] {
        guard let filter = filterRecipeId else { return recipeItems }
        return recipeItems.filter { $0.recipeId == filter }
    }

    var completedCount: Int {
        currentItems.filter(\.checked).count
    }

    var progress: Double {
        let total = Double(currentItems.count)
        guard total > 0 else { return 0 }
        return Double(completedCount) / total
    }

    func toggleItem(id: Int) {
        let current = itemStates[id] ?? false
        itemStates[id] = !current
    }

    func toggleRecipe(id: String) {
        if selectedRecipes.contains(id) {
            selectedRecipes.remove(id)
        } else {
            selectedRecipes.insert(id)
        }
    }

    func addCustomItem() {
        guard !newItemName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        // TODO: 添加到自定义列表
        newItemName = ""
        showAddForm = false
    }

    func addRecipesToShoppingList(_ recipes: [Recipe]) {
        guard !recipes.isEmpty else { return }

        var newEntries: [RecipeShoppingItems] = []

        for recipe in recipes {
            let recipeIdentifier = "import-\(recipe.id.uuidString)"

            if let index = recipeItems.firstIndex(where: { $0.recipeId == recipeIdentifier }) {
                selectedRecipes.insert(recipeIdentifier)
                let items = recipe.ingredients.map { ingredient -> RawShoppingItem in
                    let existing = recipeItems[index].items.first { $0.name == ingredient.name && $0.category == ingredient.category }
                    if let existing {
                        return existing
                    } else {
                        let item = RawShoppingItem(
                            id: generateID(),
                            name: ingredient.name,
                            amount: ingredient.amount,
                            category: ingredient.category
                        )
                        recipeItems[index].items.append(item)
                        return item
                    }
                }
                items.forEach { item in
                    if itemStates[item.id] == nil {
                        itemStates[item.id] = false
                    }
                }
                continue
            }

            let items = recipe.ingredients.map { ingredient -> RawShoppingItem in
                let id = generateID()
                return RawShoppingItem(
                    id: id,
                    name: ingredient.name,
                    amount: ingredient.amount,
                    category: ingredient.category
                )
            }

            items.forEach { item in
                if itemStates[item.id] == nil {
                    itemStates[item.id] = false
                }
            }

            let entry = RecipeShoppingItems(
                recipeId: recipeIdentifier,
                recipeName: recipe.name,
                items: items
            )
            newEntries.append(entry)
            selectedRecipes.insert(recipeIdentifier)
        }

        if !newEntries.isEmpty {
            recipeItems.append(contentsOf: newEntries)
        }
    }

    func clearAll() {
        recipeItems = []
        selectedRecipes = []
        itemStates = [:]
        filterRecipeId = nil
    }

    func uncheckAll() {
        for (key, _) in itemStates {
            itemStates[key] = false
        }
    }
    
    func removeRecipe(id: String) {
        guard let index = recipeItems.firstIndex(where: { $0.recipeId == id }) else { return }
        
        // 删除该菜谱的所有食材状态
        let itemIds = recipeItems[index].items.map(\.id)
        itemIds.forEach { itemStates.removeValue(forKey: $0) }
        
        // 从选中列表中移除
        selectedRecipes.remove(id)
        
        // 删除菜谱
        recipeItems.remove(at: index)
        
        // 如果当前筛选的是被删除的菜谱，清除筛选
        if filterRecipeId == id {
            filterRecipeId = nil
        }
    }

    private func generateID() -> Int {
        defer { nextItemID += 1 }
        return nextItemID
    }
}

