import SwiftUI

struct LinkImportResultView: View {
    let result: LinkImportResult
    let onDismiss: () -> Void
    let onCook: ([Recipe]) -> Void
    let onSave: ([Recipe]) -> Void

    @State private var selectedRecipeIDs: Set<UUID>

    init(
        result: LinkImportResult,
        onDismiss: @escaping () -> Void,
        onCook: @escaping ([Recipe]) -> Void,
        onSave: @escaping ([Recipe]) -> Void
    ) {
        self.result = result
        self.onDismiss = onDismiss
        self.onCook = onCook
        self.onSave = onSave
        _selectedRecipeIDs = State(initialValue: Set(result.recipes.map(\.id)))
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: UIStyle.Padding.xxxl) {
                    header
                    selectionList
                }
                .padding(.horizontal, UIStyle.Padding.xl)
                .padding(.bottom, UIStyle.Padding.bottomForNavigation + 20)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationTitle("识别结果")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") {
                        onDismiss()
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: UIStyle.Spacing.md) {
                    Divider()
                        .overlay(Color.orange100.opacity(0.6))
                    actionButtons
                }
                .padding(.top, UIStyle.Spacing.md)
                .padding(.horizontal, UIStyle.Padding.xl)
                .padding(.bottom, UIStyle.Padding.lg)
                .background(.ultraThinMaterial)
            }
        }
    }

    private var header: some View {
        VStack(spacing: UIStyle.LinkImport.headerSpacing) {
            // 小红书预览样式：封面与文本在同一个大气泡中
            HStack(spacing: 0) {
            AsyncImage(url: result.coverURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Color.orange100
                case .empty:
                    ProgressView()
                @unknown default:
                    Color.orange100
                }
            }
                .frame(width: UIStyle.LinkImport.headerImageSize, height: UIStyle.LinkImport.headerImageSize)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: UIStyle.LinkImport.headerCardCornerRadius,
                        style: .continuous
                    )
                )
                .clipped()

                VStack(alignment: .leading, spacing: UIStyle.Spacing.sm) {
                Text(result.title)
                        .font(.body)
                    .foregroundStyle(Color.gray800)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, UIStyle.LinkImport.headerCardPaddingH)
                .padding(.vertical, UIStyle.LinkImport.headerCardPaddingV)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: UIStyle.LinkImport.headerCardCornerRadius, style: .continuous))
            .shadow(color: UIStyle.Shadow.color.opacity(0.06), radius: 12, y: 6)
            .frame(maxWidth: .infinity, alignment: .leading)

            // 识别到菜谱提示
                Text("识别到 \(result.recipes.count) 道菜谱，默认全部导入")
                .font(.system(size: UIStyle.LinkImport.summaryFontSize))
                .foregroundStyle(Color.darkRed)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, UIStyle.Padding.xxl)
    }

    private var selectionList: some View {
        // 两列网格，卡片样式与设计稿一致
        let columns = [
            GridItem(.flexible(), spacing: UIStyle.LinkImport.gridSpacing),
            GridItem(.flexible(), spacing: UIStyle.LinkImport.gridSpacing)
        ]
        
        return LazyVGrid(columns: columns, spacing: UIStyle.LinkImport.gridSpacing) {
            ForEach(result.recipes) { recipe in
                let isSelected = selectedRecipeIDs.contains(recipe.id)
                
                Button {
                    toggle(recipe)
                } label: {
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading, spacing: UIStyle.LinkImport.cardContentSpacing) {
                            // 圆形菜谱图片
                        AsyncImage(url: recipe.imageURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure:
                                Color.orange100
                            case .empty:
                                ProgressView()
                            @unknown default:
                                Color.orange100
                            }
                        }
                            .frame(width: UIStyle.LinkImport.cardImageSize, height: UIStyle.LinkImport.cardImageSize)
                            .clipShape(Circle())

                            VStack(alignment: .leading, spacing: UIStyle.Spacing.sm) {
                            Text(recipe.name)
                                .font(.headline)
                                .foregroundStyle(Color.gray800)
                                
                                HStack(spacing: UIStyle.RecipeGridCard.timeSpacing) {
                                    Image(systemName: "clock")
                                        .font(.system(size: UIStyle.RecipeGridCard.timeIconSize))
                                        .foregroundStyle(Color.gray500)
                                    Text(recipe.time)
                                        .font(.system(size: UIStyle.RecipeGridCard.timeFontSize))
                                .foregroundStyle(Color.gray500)
                        }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(UIStyle.LinkImport.cardPadding)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: UIStyle.LinkImport.cardCornerRadius, style: .continuous))
                    .overlay(
                            RoundedRectangle(cornerRadius: UIStyle.LinkImport.cardCornerRadius, style: .continuous)
                            .stroke(
                                    isSelected ? Color.darkRed : Color.gray300,
                                    lineWidth: isSelected ? UIStyle.LinkImport.cardBorderWidth : UIStyle.Border.width
                            )
                    )
                        
                        // 右上角选中勾选标记
                        if isSelected {
                            Circle()
                                .fill(Color.darkRed)
                                .frame(width: UIStyle.LinkImport.checkBadgeSize, height: UIStyle.LinkImport.checkBadgeSize)
                                .overlay(
                                    Image(systemName: "checkmark")
                                        .font(.system(size: UIStyle.LinkImport.checkIconSize, weight: .bold))
                                        .foregroundStyle(Color.white)
                                )
                                .offset(x: -UIStyle.Spacing.md, y: UIStyle.Spacing.md)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 14) {
            // 高亮主按钮：收进菜谱库（红色）
            primaryButton(title: "收进菜谱库", systemImage: "book.fill") {
                onSave(selectedRecipes)
            }

            // 次要按钮：立即开锅（浅色背景）
            secondaryButton(
                title: "立即开锅",
                systemImage: "flame.fill",
                background: Color.white,
                foreground: Color.orange600,
                isDisabled: false
            ) {
                onCook(selectedRecipes)
            }
        }
        .disabled(selectedRecipes.isEmpty)
        .opacity(selectedRecipes.isEmpty ? 0.6 : 1)
    }

    private var selectedRecipes: [Recipe] {
        result.recipes.filter { selectedRecipeIDs.contains($0.id) }
    }

    private func toggle(_ recipe: Recipe) {
        if selectedRecipeIDs.contains(recipe.id) {
            selectedRecipeIDs.remove(recipe.id)
        } else {
            selectedRecipeIDs.insert(recipe.id)
        }
    }

    private func primaryButton(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button {
            guard !selectedRecipes.isEmpty else { return }
            action()
        } label: {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.orange500)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private func secondaryButton(
        title: String,
        systemImage: String,
        background: Color,
        foreground: Color,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            guard !selectedRecipes.isEmpty else { return }
            action()
        } label: {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundStyle(foreground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray300, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
    }
}


