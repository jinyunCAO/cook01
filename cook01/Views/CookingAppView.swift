import SwiftUI

struct CookingAppView: View {
    @State private var currentPage: Page = .home
    @State private var selectedRecipe: Recipe? = nil
    @StateObject private var shoppingViewModel = ShoppingListViewModel(recipeItems: [])
    @StateObject private var appState = AppState()

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white.ignoresSafeArea()

            // 内容区域，不添加固定 padding，让各个视图自己处理滚动
                content

            // 悬浮的导航栏，使用 ignoresSafeArea 确保它真正悬浮
            // 在详情页不显示导航栏
            if currentPage != .recipes {
            BottomBar(current: $currentPage)
                    .ignoresSafeArea(edges: .bottom)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch currentPage {
        case .home:
            HomeView(
                appState: appState,
                shoppingViewModel: shoppingViewModel,
                onRecipeTap: { recipe in
                    selectedRecipe = recipe
                    currentPage = .recipes
                },
                onStartCooking: { recipe in
                    selectedRecipe = recipe
                    currentPage = .cooking
                },
                onProfileTap: {
                    currentPage = .profile
                },
                onNavigateToShopping: {
                    currentPage = .shopping
                }
            )
        case .recipes:
            if let recipe = selectedRecipe {
                RecipeDetailView(
                    recipe: recipe,
                    onStartCooking: { recipe in
                        selectedRecipe = recipe
                        currentPage = .cooking
                    },
                    onAddToShoppingList: { recipe in
                        shoppingViewModel.addRecipesToShoppingList([recipe])
                    },
                    onNavigateToShopping: {
                        currentPage = .shopping
                    },
                    onBack: {
                        selectedRecipe = nil
                        currentPage = .home
                    }
                )
            } else {
                // 如果没有选中的菜谱，返回首页
                HomeView(
                    appState: appState,
                    shoppingViewModel: shoppingViewModel,
                    onRecipeTap: { recipe in
                        selectedRecipe = recipe
                        currentPage = .recipes
                    },
                    onStartCooking: { recipe in
                        selectedRecipe = recipe
                        currentPage = .cooking
                    },
                    onProfileTap: {
                        currentPage = .profile
                    },
                    onNavigateToShopping: {
                        currentPage = .shopping
                    }
                )
            }
        case .cooking:
            CookingModeView(
                recipe: selectedRecipe,
                onExit: {
                    // 完成烹饪后，清除选中的菜谱，回到空状态
                    selectedRecipe = nil
                    currentPage = .home
                }
            )
        case .shopping:
            ShoppingListView(viewModel: shoppingViewModel, appState: appState)
        case .profile:
            ProfileView()
        }
    }
    
}

