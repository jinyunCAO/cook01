import Foundation
import SwiftUI

struct ProfileStat: Identifiable {
    let id: UUID = UUID()
    let iconName: String
    let label: String
    let value: String
    let colors: [Color]
}

struct RecentCook: Identifiable {
    let id: UUID = UUID()
    let name: String
    let times: Int
    let lastCooked: String
}

struct ProfileMenuItem: Identifiable {
    let id: UUID = UUID()
    let iconName: String
    let label: String
    let badge: String?
    let tint: Color
}

