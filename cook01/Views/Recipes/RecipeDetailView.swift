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
                VStack(spacing: 24) {
                    hero
                    tabSwitcher
                    tabContent
                    actionButtons
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                .padding(.top, 24)
                .frame(width: geometry.size.width)
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 0)
            }
            .overlay(alignment: .topLeading) {
                if let onBack {
                    VStack {
                        HStack {
                            Button {
                                onBack()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.headline.bold())
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                            .padding(.leading, 16)
                            .buttonStyle(.plain)
                            Spacer()
                        }
                        .padding(.top, 8)
                        Spacer()
                    }
                }
            }
        }
    }

    private var hero: some View {
        ZStack(alignment: .bottom) {
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
            .frame(height: 260)
            .frame(maxWidth: .infinity)
            .clipped()

            VStack(alignment: .leading, spacing: 12) {
                Text(recipe.name)
                    .font(.title.bold())
                    .foregroundStyle(Color.gray800)

                Text(recipe.description)
                    .foregroundStyle(Color.gray600)

                HStack(spacing: 12) {
                    InfoRow(icon: "clock", text: recipe.time, tint: .orange600)
                    InfoRow(icon: "person.2.fill", text: recipe.servings, tint: .amber700)
                    InfoRow(icon: "flame.fill", text: recipe.difficulty, tint: .red500)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.gray300, lineWidth: 1)
            )
            .padding(.horizontal, 0)
            .offset(y: 36)
        }
        .padding(.bottom, 44)
    }

    private var tabSwitcher: some View {
        HStack(spacing: 0) {
            tabButton(.ingredients, title: "食材清单", systemImage: "cart.fill")
            tabButton(.steps, title: "烹饪步骤", systemImage: "chef.hat.fill")
        }
        .padding(4)
        .background(Color.gray200.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private func tabButton(_ tab: DetailTab, title: String, systemImage: String) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                    .font(.system(size: 14, weight: .medium))
                Text(title)
                    .font(.subheadline.weight(.medium))
            }
            .foregroundStyle(selectedTab == tab ? Color.orange700 : Color.gray600)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .background(
                Group {
                    if selectedTab == tab {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.white)
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
            VStack(spacing: 16) {
                let categories: [IngredientCategory] = [.main, .supplement, .seasoning]
                ForEach(categories, id: \.self) { category in
                    let items = recipe.ingredients.filter { $0.category == category }
                    if !items.isEmpty {
                        IngredientGroup(category: category.rawValue, items: items)
                    }
                }

            }
            .transition(.move(edge: .trailing).combined(with: .opacity))

        case .steps:
            VStack(spacing: 18) {
                ForEach(recipe.steps) { step in
                    StepCard(step: step)
                }
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 12) {
            if let onAddToShoppingList = onAddToShoppingList {
                Button {
                    onAddToShoppingList(recipe)
                    onNavigateToShopping?()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "cart.badge.plus")
                        Text("添加到清单")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .foregroundStyle(Color.orange700)
                    .background(Color.orange100)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.orange300, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
            
            Button {
                onStartCooking(recipe)
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                    Text("开始烹饪")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(Color.white)
                .background(Color.orange500)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 12)
    }
}

