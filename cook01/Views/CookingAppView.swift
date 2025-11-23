import SwiftUI

struct CookingAppView: View {
    @State private var currentPage: Page = .home
    @State private var selectedRecipe: Recipe? = nil
    @StateObject private var shoppingViewModel = ShoppingListViewModel(recipeItems: [])
    @StateObject private var appState = AppState()

    var body: some View {
        ZStack(alignment: .bottom) {
            GradientBackground()

            VStack(spacing: 0) {
                content
                    .padding(.bottom, 76)
            }

            BottomBar(current: $currentPage)
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

