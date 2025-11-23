import SwiftUI

// 菜谱卡片（按菜谱模式）
struct SwipeableShoppingRecipeCard: View {
    let recipe: RecipeShoppingItems
    let itemStates: [Int: Bool]
    let onItemToggle: (Int) -> Void
    let onRecipeTap: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    onRecipeTap()
                } label: {
                    Text(recipe.recipeName)
                        .font(.headline)
                        .foregroundStyle(Color.orange600)
                }
                .buttonStyle(.plain)
                Spacer()
                HStack(spacing: 8) {
                    Text("\(recipe.items.count) 项")
                        .font(.caption)
                        .foregroundStyle(Color.gray500)
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            onDelete()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.caption)
                            .foregroundStyle(Color.red)
                            .padding(6)
                            .background(Color.red.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
            ForEach(recipe.items, id: \.id) { item in
                shoppingRow(item: item, checked: itemStates[item.id] ?? false, metadata: recipe.recipeName)
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }
    
    private func shoppingRow(item: RawShoppingItem, checked: Bool, metadata: String?) -> some View {
        HStack(spacing: 12) {
            Button {
                onItemToggle(item.id)
            } label: {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(checked ? Color.green400 : Color.white)
                    .frame(width: 28, height: 28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(checked ? Color.green400 : Color.orange300, lineWidth: 2)
                    )
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.white)
                            .opacity(checked ? 1 : 0)
                    )
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline)
                    .foregroundStyle(checked ? Color.gray400 : Color.gray800)
                    .strikethrough(checked)
                Text(item.amount)
                    .font(.caption)
                    .foregroundStyle(Color.orange600)
            }

            Spacer()

            if let metadata {
                Text(metadata)
                    .font(.caption2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.orange50)
                    .foregroundStyle(Color.orange600)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(
            checked ? Color.green400.opacity(0.12) : Color.orange50
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

// 菜谱选择项
struct SwipeableRecipeSelectorItem: View {
    let recipe: RecipeShoppingItems
    let isSelected: Bool
    let onToggle: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                onToggle()
            } label: {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(
                        isSelected ? Color.orange500 : Color.gray300,
                        lineWidth: 2
                    )
                    .background(
                        isSelected ? Color.orange500 : Color.white
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.white)
                            .opacity(isSelected ? 1 : 0)
                    )
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.recipeName)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(
                        isSelected ? Color.orange700 : Color.gray700
                    )
                Text("\(recipe.items.count) 项食材")
                    .font(.caption)
                    .foregroundStyle(Color.gray500)
            }

            Spacer()
            
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    onDelete()
                }
            } label: {
                Image(systemName: "trash")
                    .font(.caption)
                    .foregroundStyle(Color.red)
                    .padding(6)
                    .background(Color.red.opacity(0.1))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            isSelected ? Color.orange50 : Color.gray200.opacity(0.3)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(
                    isSelected ? Color.orange500 : Color.gray300,
                    lineWidth: isSelected ? 2 : 1
                )
        )
    }
}

struct ShoppingListView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    var appState: AppState? = nil

    init(viewModel: ShoppingListViewModel = ShoppingListViewModel(), appState: AppState? = nil) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.appState = appState
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
                header
                if viewModel.recipeItems.isEmpty {
                    emptyState
                } else {
                    addMoreBar
                    modeSwitcher
                    if viewModel.viewMode == .merged {
                        recipeSelector
                    }
                    Section {
                        itemsSection
                        addItemSection
                        if viewModel.progress >= 1 && !viewModel.currentItems.isEmpty {
                            completionCard
                        } else {
                            tipCard
                        }
                    } header: {
                        progressHeader
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 40)
        }
    }

    // 当前筛选菜谱名称
    private var currentFilteredRecipeName: String? {
        guard let id = viewModel.filterRecipeId else { return nil }
        return viewModel.recipeItems.first(where: { $0.recipeId == id })?.recipeName
    }

    private var addMoreBar: some View {
        HStack(spacing: 12) {
            Spacer()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(colors: [.amber100, .orange100], startPoint: .leading, endPoint: .trailing)
                )
                .overlay(
                    VStack(spacing: 6) {
                        Text("清单为空")
                            .font(.headline)
                            .foregroundStyle(Color.orange800)
                        Text("从首页导入菜谱，开始你的购物之旅")
                            .font(.subheadline)
                            .foregroundStyle(Color.orange700)
                    }
                    .padding()
                )
                .frame(height: 96)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    private var completionCard: some View {
        VStack(spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(Color.green400)
                Text("🎉 太棒了，已买齐所有食材！")
                    .font(.headline)
                    .foregroundStyle(Color.gray800)
                Spacer()
            }
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                    viewModel.clearAll()
                }
            } label: {
                Label("清空清单", systemImage: "trash")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(LightButtonStyle())
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                if viewModel.viewMode == .byRecipe, viewModel.filterRecipeId != nil {
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            viewModel.filterRecipeId = nil
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.headline.bold())
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.orange100, lineWidth: 1))
                            Text("返回所有菜谱")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.gray700)
                        }
                    }
                    .buttonStyle(.plain)
                }
                Text(viewModel.filterRecipeId == nil ? "购物清单" : (currentFilteredRecipeName ?? "菜谱详情"))
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.gray800)
                AnimatedCartIcon()
            }
            Text("已完成 \(viewModel.completedCount) / \(viewModel.currentItems.count) 项")
                .foregroundStyle(Color.gray600)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var modeSwitcher: some View {
        HStack(spacing: 12) {
            ModeButton(title: "按菜谱", systemImage: "square.grid.3x3.fill", selected: viewModel.viewMode == .byRecipe) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    viewModel.viewMode = .byRecipe
                }
            }

            ModeButton(title: "智能合并", systemImage: "list.bullet.rectangle", selected: viewModel.viewMode == .merged) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    viewModel.viewMode = .merged
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    private var recipeSelector: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("选择要购买的菜谱")
                .font(.subheadline)
                .foregroundStyle(Color.orange600)
                .padding(.horizontal, 4)

            ForEach(viewModel.recipeItems, id: \.recipeId) { recipe in
                SwipeableRecipeSelectorItem(
                    recipe: recipe,
                    isSelected: viewModel.selectedRecipes.contains(recipe.recipeId),
                    onToggle: {
                        viewModel.toggleRecipe(id: recipe.recipeId)
                    },
                    onDelete: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            viewModel.removeRecipe(id: recipe.recipeId)
                        }
                    }
                )
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    private var progressHeader: some View {
        VStack {
            progressCard
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(
            Color(.systemBackground)
                .opacity(0.96)
                .ignoresSafeArea(edges: .top)
        )
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("采购进度")
                    .font(.headline)
                    .foregroundStyle(Color.gray700)
                Spacer()
                Text("\(Int(viewModel.progress * 100))%")
                    .font(.headline)
                    .foregroundStyle(Color.orange600)
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray300)
                    
                    Capsule()
                        .fill(Color.orange500)
                        .frame(width: proxy.size.width * viewModel.progress)
                }
            }
            .frame(height: 8)

            if viewModel.progress >= 1 {
                Text("🎉 太棒了！全部采购完成！")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.green400)
                    .transition(.opacity)
            }
        }
        .padding(24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var itemsSection: some View {
        switch viewModel.viewMode {
        case .byRecipe:
            VStack(spacing: 18) {
                ForEach(viewModel.filteredRecipeItems, id: \.recipeId) { recipe in
                    SwipeableShoppingRecipeCard(
                        recipe: recipe,
                        itemStates: viewModel.itemStates,
                        onItemToggle: { itemId in
                            viewModel.toggleItem(id: itemId)
                        },
                        onRecipeTap: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                                viewModel.filterRecipeId = recipe.recipeId
                            }
                        },
                        onDelete: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                viewModel.removeRecipe(id: recipe.recipeId)
                            }
                        }
                    )
                }
            }
        case .merged:
            VStack(alignment: .leading, spacing: 16) {
                ForEach(IngredientCategory.allCases, id: \.self) { category in
                    let items = viewModel.mergedItems.filter { $0.category == category }
                    if !items.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(category.rawValue)
                                .font(.headline)
                                .foregroundStyle(Color.orange600)
                            ForEach(items) { item in
                                mergedRow(item: item)
                            }
                        }
                        .padding(20)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.gray300, lineWidth: 1)
                        )
                    }
                }
            }
        }
    }

    private func shoppingRow(item: RawShoppingItem, checked: Bool, metadata: String?) -> some View {
        HStack(spacing: 12) {
            Button {
                viewModel.toggleItem(id: item.id)
            } label: {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(checked ? Color.green400 : Color.white)
                    .frame(width: 28, height: 28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(checked ? Color.green400 : Color.orange300, lineWidth: 2)
                    )
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.white)
                            .opacity(checked ? 1 : 0)
                    )
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline)
                    .foregroundStyle(checked ? Color.gray400 : Color.gray800)
                    .strikethrough(checked)
                Text(item.amount)
                    .font(.caption)
                    .foregroundStyle(Color.orange600)
            }

            Spacer()

            if let metadata {
                Text(metadata)
                    .font(.caption2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.orange50)
                    .foregroundStyle(Color.orange600)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(
            checked ? Color.green400.opacity(0.12) : Color.orange50
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private func mergedRow(item: ShoppingItem) -> some View {
        HStack(spacing: 12) {
            Button {
                viewModel.toggleItem(id: item.id)
            } label: {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(item.checked ? Color.green400 : Color.white)
                    .frame(width: 28, height: 28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(item.checked ? Color.green400 : Color.orange300, lineWidth: 2)
                    )
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.white)
                            .opacity(item.checked ? 1 : 0)
                    )
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(item.checked ? Color.gray400 : Color.gray800)
                    .strikethrough(item.checked)

                Text(item.joinedAmounts)
                    .font(.caption)
                    .foregroundStyle(Color.orange600)

                if !item.recipes.isEmpty {
                    Text("来自：\(item.recipes.joined(separator: " + "))")
                        .font(.caption2)
                        .foregroundStyle(Color.gray500)
                }
            }

            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(item.checked ? Color.green400.opacity(0.12) : Color.orange50)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var addItemSection: some View {
        VStack(spacing: 16) {
            if viewModel.showAddForm {
                VStack(spacing: 12) {
                    Text("添加新食材")
                        .font(.headline)
                        .foregroundStyle(Color.gray800)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("食材名称", text: $viewModel.newItemName)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color.gray200.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.gray300, lineWidth: 1)
                        )

                    HStack(spacing: 12) {
                        Button("确认添加") {
                            viewModel.addCustomItem()
                        }
                        .buttonStyle(PrimaryGradientButtonStyle())

                        Button("取消") {
                            withAnimation {
                                viewModel.showAddForm = false
                                viewModel.newItemName = ""
                            }
                        }
                        .buttonStyle(LightButtonStyle())
                    }
                }
                .padding(24)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray300, lineWidth: 1)
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                Button {
                    withAnimation {
                        viewModel.showAddForm = true
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus.circle.fill")
                        Text("添加食材")
                            .font(.headline)
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
        }
    }

    private var tipCard: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.orange100)
            .overlay(
                Text("💡 小贴士：清单会自动合并相同食材哦~")
                    .font(.subheadline)
                    .foregroundStyle(Color.orange700)
                    .padding()
            )
            .frame(height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.orange300, lineWidth: 1)
            )
    }
}

