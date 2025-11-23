import Foundation

struct LinkImportResult: Identifiable {
    let id: UUID = UUID()
    let title: String
    let coverURL: URL
    let recipes: [Recipe]
}


