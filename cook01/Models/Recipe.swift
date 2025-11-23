import Foundation

struct Recipe: Identifiable {
    let id: UUID = UUID()
    let name: String
    let imageURL: URL
    let description: String
    let time: String
    let servings: String
    let difficulty: String
    let tags: [String]
    let likes: Int
    let savedAt: String?
    let ingredients: [Ingredient]
    let steps: [Step]
}

