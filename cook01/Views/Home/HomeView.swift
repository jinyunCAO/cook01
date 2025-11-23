import SwiftUI

// 支持右划删除的菜谱卡片
struct SwipeableRecipeCard: View {
    let recipe: Recipe
    let isSelected: Bool
    let showCheckbox: Bool
    let onTap: () -> Void
    let onDetailTap: () -> Void
    let onDelete: () -> Void
    
    @State private var dragOffset: CGFloat = 0
    @State private var isDeleting: Bool = false
    
    private let deleteThreshold: CGFloat = -80
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // 删除按钮背景
            if dragOffset < 0 {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            isDeleting = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onDelete()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .frame(width: 60, height: 60)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 16)
                }
            }
            
            // 菜谱卡片
            RecipeCard(
                recipe: recipe,
                isSelected: isSelected,
                showCheckbox: showCheckbox,
                onTap: onTap,
                onDetailTap: onDetailTap
            )
            .offset(x: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            dragOffset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        if value.translation.width < deleteThreshold {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isDeleting = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onDelete()
                            }
                        } else {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                dragOffset = 0
                            }
                        }
                    }
            )
            .opacity(isDeleting ? 0 : 1)
            .scaleEffect(isDeleting ? 0.8 : 1)
        }
    }
}

struct HomeView: View {
    @ObservedObject var appState: AppState
    var shoppingViewModel: ShoppingListViewModel?
    @State private var url: String = ""
    @State private var isImporting: Bool = false
    @State private var importStatus: ImportStatus?
    @State private var importResult: LinkImportResult?
    @State private var selectedRecipeIDs: Set<UUID> = []
    @State private var isMultiSelectMode: Bool = false
    @State private var lastImportedURL: String = ""

    let onRecipeTap: (Recipe) -> Void
    let onStartCooking: (Recipe) -> Void
    let onProfileTap: (() -> Void)?
    let onNavigateToShopping: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    header
                    importCard
                    recipesSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
                .frame(width: geometry.size.width)
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 0)
            }
        }
        .sheet(item: $importResult) { result in
            LinkImportResultView(
                result: result,
                onDismiss: {
                    importResult = nil
                },
                onCook: { recipes in
                    importResult = nil
                    guard let first = recipes.first else { return }
                    onStartCooking(first)
                },
                onSave: { recipes in
                    // 保存选中的菜谱到 linkHistory
                    let selectedResult = LinkImportResult(
                        title: result.title,
                        coverURL: result.coverURL,
                        recipes: recipes
                    )
                    addHistoryEntry(selectedResult, sourceURL: lastImportedURL)
                    importResult = nil
                }
            )
        }
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 16) {
            // 左侧头像
            Group {
                if let onProfileTap = onProfileTap {
                    Button {
                        onProfileTap()
                    } label: {
                        avatarView
                    }
                    .buttonStyle(.plain)
                } else {
                    avatarView
                }
            }
            
            // 右侧问候文本
            VStack(alignment: .leading, spacing: 6) {
                Text("Hello, 晋云")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.gray800)
                
                Text("今天想做什么好吃的?")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.gray600)
            }
            .frame(height: 56, alignment: .leading)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var avatarView: some View {
        AsyncImage(url: URL(string: "https://sns-avatar-qc.xhscdn.com/avatar/6445e687a870649a5851e88c.jpg?imageView2/2/w/540/format/webp%7CimageMogr2/strip2")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_), .empty:
                ZStack {
                    Circle()
                        .fill(Color.gray300)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.gray500)
                }
            @unknown default:
                ZStack {
                    Circle()
                        .fill(Color.gray300)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.gray500)
                }
            }
        }
        .frame(width: 56, height: 56)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, y: 2)
    }

    private var importCard: some View {
        HStack(spacing: 12) {
            // 左侧链接图标
            Image(systemName: "link")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.gray500)
            
            // 输入框
            TextField("粘贴一下,马上开饭!", text: $url)
                .textInputAutocapitalization(.none)
                .disableAutocorrection(true)
                .font(.body)
                .foregroundStyle(Color.gray800)
                .submitLabel(.go)
                .onSubmit {
                    if !url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        importAction()
                    }
                }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(Color.gray200.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    @ViewBuilder
    private var recipesSection: some View {
        let allRecipes = appState.linkHistory.flatMap { $0.result.recipes }
        
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("识别到的菜谱")
                    .font(.title3.bold())
                    .foregroundStyle(Color.gray800)
                
                Spacer()
                
                if !allRecipes.isEmpty {
                    if isMultiSelectMode {
                        if !selectedRecipeIDs.isEmpty {
                            HStack(spacing: 12) {
                                Button {
                                    addSelectedToShoppingList()
                                } label: {
                                    Label("添加到清单(\(selectedRecipeIDs.count))", systemImage: "cart.badge.plus")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(Color.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.orange500)
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    withAnimation {
                                        isMultiSelectMode = false
                                        selectedRecipeIDs.removeAll()
                                    }
                                } label: {
                                    Text("取消")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(Color.gray600)
                                }
                                .buttonStyle(.plain)
                            }
                        } else {
                            HStack(spacing: 12) {
                                Button {
                                    withAnimation {
                                        selectedRecipeIDs = Set(allRecipes.map(\.id))
                                    }
                                } label: {
                                    Text("全选")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(Color.orange600)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    withAnimation {
                                        isMultiSelectMode = false
                                    }
                                } label: {
                                    Text("取消")
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(Color.gray600)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    } else {
                        Button {
                            withAnimation {
                                isMultiSelectMode = true
                            }
                        } label: {
                            Text("多选")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.orange600)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            if allRecipes.isEmpty {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        style: StrokeStyle(lineWidth: 1, dash: [8, 6])
                    )
                    .foregroundStyle(Color.gray300)
                    .overlay(
                        Text("🎨 试试从小红书导入你喜欢的菜谱吧！")
                            .font(.body)
                            .foregroundStyle(Color.gray700)
                            .multilineTextAlignment(.center)
                            .padding()
                    )
                    .frame(height: 120)
            } else {
                VStack(spacing: 14) {
                    ForEach(allRecipes) { recipe in
                        SwipeableRecipeCard(
                            recipe: recipe,
                            isSelected: selectedRecipeIDs.contains(recipe.id),
                            showCheckbox: isMultiSelectMode,
                            onTap: {
                                if isMultiSelectMode {
                                    if selectedRecipeIDs.contains(recipe.id) {
                                        selectedRecipeIDs.remove(recipe.id)
                                    } else {
                                        selectedRecipeIDs.insert(recipe.id)
                                    }
                                }
                            },
                            onDetailTap: {
                                if !isMultiSelectMode {
                                    onRecipeTap(recipe)
                                }
                            },
                            onDelete: {
                                deleteRecipe(recipe)
                            }
                        )
                    }
                }
            }
        }
    }
    
    private func addSelectedToShoppingList() {
        guard let shoppingViewModel = shoppingViewModel else { return }
        let allRecipes = appState.linkHistory.flatMap { $0.result.recipes }
        let selectedRecipes = allRecipes.filter { selectedRecipeIDs.contains($0.id) }
        shoppingViewModel.addRecipesToShoppingList(selectedRecipes)
        withAnimation {
            selectedRecipeIDs.removeAll()
            isMultiSelectMode = false
        }
        // 跳转到购物清单页
        onNavigateToShopping?()
    }
    
    private func deleteRecipe(_ recipe: Recipe) {
        withAnimation {
            // 找到包含该菜谱的 entry
            if let index = appState.linkHistory.firstIndex(where: { entry in
                entry.result.recipes.contains { $0.id == recipe.id }
            }) {
                let entry = appState.linkHistory[index]
                let remainingRecipes = entry.result.recipes.filter { $0.id != recipe.id }
                
                if remainingRecipes.isEmpty {
                    // 如果没有剩余菜谱，删除整个 entry
                    appState.linkHistory.remove(at: index)
                } else {
                    // 如果有剩余菜谱，创建新的 entry
                    let newResult = LinkImportResult(
                        title: entry.result.title,
                        coverURL: entry.result.coverURL,
                        recipes: remainingRecipes
                    )
                    let newEntry = LinkHistoryEntry(
                        result: newResult,
                        sourceURL: entry.sourceURL,
                        timestamp: entry.timestamp
                    )
                    appState.linkHistory[index] = newEntry
                }
            }
            selectedRecipeIDs.remove(recipe.id)
        }
    }

    private func importAction() {
        let trimmed = url.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        guard URL(string: trimmed) != nil else {
            withAnimation {
                importStatus = .failure(message: "链接格式不太对劲，检查后再试试吧")
            }
            return
        }

        isImporting = true
        withAnimation {
            importStatus = nil
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isImporting = false
            if let result = MockData.linkResult(forURL: trimmed) {
                lastImportedURL = trimmed
                url = ""
                // 不立即保存，等用户点击"收进菜谱库"时再保存
                importResult = result
            } else {
                withAnimation {
                    importStatus = .failure(message: "暂未收录该菜谱，可以尝试其它链接")
                }
            }
        }
    }

    private var importHint: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.amber50)
            .overlay(
                Text("💡 粘贴一下马上开饭~")
                    .font(.footnote)
                    .foregroundStyle(Color.amber700)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8),
                alignment: .leading
            )
            .frame(height: 44)
    }

    private func importStatusView(for status: ImportStatus) -> some View {
        HStack(spacing: 10) {
            Image(systemName: status.iconName)
                .font(.subheadline.weight(.semibold))
            Text(status.message)
                .font(.footnote)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(status.backgroundColor)
        .foregroundStyle(status.textColor)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(status.borderColor, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var statusSection: some View {
        if let importStatus {
            importStatusView(for: importStatus)
                .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }

    private func addHistoryEntry(_ result: LinkImportResult, sourceURL: String) {
        let entry = LinkHistoryEntry(result: result, sourceURL: sourceURL, timestamp: Date())
        appState.linkHistory.removeAll { $0.sourceURL == sourceURL }
        appState.linkHistory.insert(entry, at: 0)
        if appState.linkHistory.count > 12 {
            appState.linkHistory = Array(appState.linkHistory.prefix(12))
        }
    }
}


extension HomeView {
    enum ImportStatus: Equatable {
        case success(message: String)
        case failure(message: String)

        var message: String {
            switch self {
            case .success(let message), .failure(let message):
                return message
            }
        }

        var iconName: String {
            switch self {
            case .success:
                return "checkmark.circle.fill"
            case .failure:
                return "exclamationmark.triangle.fill"
            }
        }

        var backgroundColor: Color {
            switch self {
            case .success:
                return Color.green400.opacity(0.15)
            case .failure:
                return Color.orange100.opacity(0.6)
            }
        }

        var borderColor: Color {
            switch self {
            case .success:
                return Color.green400.opacity(0.4)
            case .failure:
                return Color.orange200
            }
        }

        var textColor: Color {
            switch self {
            case .success:
                return Color.green400
            case .failure:
                return Color.orange700
            }
        }
    }
}
