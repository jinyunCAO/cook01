import Foundation

struct LinkHistoryEntry: Identifiable {
    let id: UUID = UUID()
    let result: LinkImportResult
    let sourceURL: String
    let timestamp: Date
}


