import SwiftUI

enum Page: String, CaseIterable, Identifiable {
    case home
    case recipes
    case cooking
    case shopping
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "煮趣"
        case .recipes: return "菜谱"
        case .cooking: return "烹饪"
        case .shopping: return "清单"
        case .profile: return "我的"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "fork.knife"
        case .recipes: return "book"
        case .cooking: return "flame.fill"
        case .shopping: return "cart.fill"
        case .profile: return "person.crop.circle"
        }
    }
}

struct BottomBar: View {
    @Binding var current: Page

    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .foregroundStyle(Color.orange100)

            HStack {
                ForEach(Page.allCases.filter { $0 != .profile && $0 != .recipes }) { page in
                    let isActive = current == page

                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            current = page
                        }
                    } label: {
                        VStack(spacing: 6) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(isActive ? Color.orange100 : Color.clear)
                                    .frame(width: 44, height: 44)

                                Image(systemName: page.systemImage)
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(
                                        isActive ? Color.orange600 : Color.gray400
                                    )
                            }

                            Text(page.title)
                                .font(.caption2)
                                .foregroundStyle(isActive ? Color.orange600 : Color.gray500)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(Color.white)
        }
    }
}

