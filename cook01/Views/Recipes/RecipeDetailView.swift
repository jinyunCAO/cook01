import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    var onStartCooking: (Recipe) -> Void
    var onAddToShoppingList: ((Recipe) -> Void)? = nil
    var onNavigateToShopping: (() -> Void)? = nil
    var onBack: (() -> Void)? = nil

    @State private var selectedTab: DetailTab = .ingredients
    @Namespace private var tabNamespace

    enum DetailTab { case ingredients, steps }

    var body: some View {
        GeometryReader { geometry in
        ScrollView(showsIndicators: false) {
            VStack(spacing: UIStyle.Cooking.contentSpacing) {
                hero
                tabSwitcher
                tabContent
            }
            .padding(.horizontal, UIStyle.Padding.lg)
            .padding(.top, 0)
            .padding(.bottom, 100) // 为底部悬浮按钮留出空间
            .frame(width: geometry.size.width)
        }
        .background(Color.white.ignoresSafeArea())
        .overlay(alignment: .topLeading) {
            // 悬浮固定的返回按钮
            if let onBack {
                Button {
                    onBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline.bold())
                        .foregroundStyle(Color.white)
                        .padding(UIStyle.RecipeDetail.backButtonPadding)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .padding(.leading, UIStyle.Padding.lg)
                .padding(.top, UIStyle.Spacing.sm)
                .buttonStyle(.plain)
            }
        }
        .safeAreaInset(edge: .bottom) {
            // 悬浮固定的底部按钮
            actionButtons
                .padding(.horizontal, UIStyle.Padding.lg)
                .padding(.bottom, UIStyle.Padding.lg)
                .background(Color.white)
            }
        }
    }

    private var hero: some View {
        VStack(spacing: 0) {
            // 预览图
            AsyncImage(url: recipe.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    Color.orange100
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 48))
                                .foregroundStyle(Color.orange400)
                        )
                case .empty:
                    ProgressView()
                @unknown default:
                    Color.orange100
                }
            }
            .frame(height: UIStyle.RecipeDetail.heroImageHeight)
            .frame(maxWidth: .infinity)
            .clipped()

            // 标题和描述信息（在图片下方）
            VStack(alignment: .leading, spacing: UIStyle.RecipeDetail.heroSpacing) {
                Text(recipe.name)
                    .font(.title.bold())
                    .foregroundStyle(Color.gray800)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray600)

                HStack(spacing: UIStyle.RecipeDetail.heroInfoSpacing) {
                    InfoRow(icon: "clock", text: recipe.time, tint: .orange600)
                    InfoRow(icon: "person.2.fill", text: recipe.servings, tint: .amber700)
                    InfoRow(icon: "chef.hat.fill", text: recipe.difficulty, tint: .red500)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, UIStyle.Padding.lg)
        }
    }

    private var tabSwitcher: some View {
        HStack(spacing: 0) {
            tabButton(.ingredients, title: "食材清单", systemImage: "cart.fill")
            tabButton(.steps, title: "烹饪步骤", systemImage: "chef.hat.fill")
        }
        .padding(UIStyle.Spacing.xs)
        .background(Color.gray200.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.medium, style: .continuous))
    }

    private func tabButton(_ tab: DetailTab, title: String, systemImage: String) -> some View {
        Button {
            withAnimation(.spring(response: UIStyle.Animation.springResponse, dampingFraction: UIStyle.Animation.springDamping)) {
                selectedTab = tab
            }
        } label: {
            HStack(spacing: UIStyle.Spacing.xs + 2) {
                Image(systemName: systemImage)
                    .font(.system(size: UIStyle.FontSize.footnote, weight: .medium))
                Text(title)
                    .font(.subheadline.weight(.medium))
            }
            .foregroundStyle(selectedTab == tab ? Color.darkRed : Color.gray500)
            .frame(maxWidth: .infinity)
            .padding(.vertical, UIStyle.Spacing.sm + 2)
            .padding(.horizontal, UIStyle.Spacing.sm)
            .background(
                Group {
                    if selectedTab == tab {
                        RoundedRectangle(cornerRadius: UIStyle.CornerRadius.small, style: .continuous)
                            .fill(Color.yellow50)
                    } else {
                        RoundedRectangle(cornerRadius: UIStyle.CornerRadius.small, style: .continuous)
                            .fill(Color.gray200.opacity(0.5))
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .ingredients:
            VStack(alignment: .leading, spacing: UIStyle.Spacing.lg) {
                let categories: [IngredientCategory] = [.main, .supplement, .seasoning]
                ForEach(categories, id: \.self) { category in
                    let items = recipe.ingredients.filter { $0.category == category }
                    if !items.isEmpty {
                        IngredientGroup(category: category.rawValue, items: items)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .transition(.move(edge: .trailing).combined(with: .opacity))

        case .steps:
            VStack(spacing: UIStyle.Spacing.md) {
                ForEach(recipe.steps) { step in
                    StepCard(step: step)
                }
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }

    private var actionButtons: some View {
        HStack(spacing: UIStyle.Spacing.md) {
            // 收进菜谱库（左侧，深红色主按钮）
            if let onAddToShoppingList = onAddToShoppingList {
                Button {
                    onAddToShoppingList(recipe)
                    onNavigateToShopping?()
                } label: {
                    Text("收进菜谱库")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, UIStyle.Padding.lg)
                        .foregroundStyle(Color.white)
                        .background(Color.darkRed)
                        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
                }
                .buttonStyle(.plain)
            }
            
            // 立即开锅（右侧，浅色次级按钮）
        Button {
            onStartCooking(recipe)
        } label: {
                Text("立即开锅")
                    .font(.headline)
                    .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
                    .padding(.vertical, UIStyle.Padding.lg)
                    .foregroundStyle(Color.darkRed)
                    .background(Color.orange50)
                    .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
        }
        .buttonStyle(.plain)
        }
    }
}

