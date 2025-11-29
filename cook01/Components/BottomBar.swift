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
        case .home: return "fork.knife"  // 使用刀叉图标表达cook概念
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
            HStack {
            // 明确指定要显示的三个页面：首页、烹饪、购物
            ForEach([Page.home, Page.cooking, Page.shopping], id: \.self) { page in
                    let isActive = current == page

                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            current = page
                        }
                    } label: {
                            ZStack {
                        // 激活状态：深红色圆形背景
                        if isActive {
                                    Circle()
                                .fill(Color.darkRed)
                                .frame(width: UIStyle.BottomBar.activeCircleSize, height: UIStyle.BottomBar.activeCircleSize)
                                }

                        // 图标
                                Image(systemName: page.systemImage)
                            .font(.system(size: UIStyle.BottomBar.iconSize, weight: .medium))
                                    .foregroundStyle(
                                isActive ? Color.white : Color.gray400
                                    )
                        }
                        .frame(maxWidth: .infinity)
                    .frame(height: UIStyle.BottomBar.activeCircleSize)
                    }
                    .buttonStyle(.plain)
                }
            }
        .padding(.horizontal, UIStyle.BottomBar.horizontalPadding)
        .padding(.vertical, UIStyle.BottomBar.verticalPadding)
            .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: UIStyle.BottomBar.cornerRadius, style: .continuous))
        .padding(.horizontal, UIStyle.BottomBar.outerHorizontalPadding)
        .padding(.bottom, UIStyle.BottomBar.bottomPadding)
        .shadow(color: UIStyle.Shadow.color.opacity(UIStyle.Shadow.opacity), radius: UIStyle.Shadow.radius, y: UIStyle.Shadow.y)
    }
}

