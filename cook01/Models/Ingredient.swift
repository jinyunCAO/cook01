import Foundation

struct Ingredient: Identifiable {
    let id: UUID = UUID()
    let name: String
    let amount: String
    let category: IngredientCategory
}

enum IngredientCategory: String, CaseIterable {
    case main = "主料"
    case supplement = "配料"
    case seasoning = "调料"
    case vegetable = "蔬菜"
    case meat = "肉类"
    case dairy = "蛋奶"
    case staple = "主食"
    case other = "其他"
}

