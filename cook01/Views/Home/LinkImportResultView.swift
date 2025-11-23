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
                VStack(spacing: 28) {
                    header
                    selectionList
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
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
                VStack(spacing: 12) {
                    Divider()
                        .overlay(Color.orange100.opacity(0.6))
                    actionButtons
                }
                .padding(.top, 12)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                .background(.ultraThinMaterial)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 16) {
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
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.gray300, lineWidth: 1)
            )

            VStack(spacing: 8) {
                Text(result.title)
                    .font(.title2.bold())
                    .foregroundStyle(Color.gray800)
                    .multilineTextAlignment(.center)
                Text("识别到 \(result.recipes.count) 道菜谱，默认全部导入")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray600)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 24)
    }

    private var selectionList: some View {
        VStack(alignment: .leading, spacing: 18) {
            ForEach(result.recipes) { recipe in
                Button {
                    toggle(recipe)
                } label: {
                    HStack(spacing: 16) {
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
                        .frame(width: 72, height: 72)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(recipe.name)
                                .font(.headline)
                                .foregroundStyle(Color.gray800)
                            Text("\(recipe.time) · \(recipe.servings)")
                                .font(.caption)
                                .foregroundStyle(Color.gray500)
                        }

                        Spacer()

                        Image(systemName: selectedRecipeIDs.contains(recipe.id) ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                            .foregroundStyle(
                                selectedRecipeIDs.contains(recipe.id) ? Color.orange500 : Color.gray300
                            )
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        selectedRecipeIDs.contains(recipe.id) ? Color.orange50 : Color.white
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(
                                selectedRecipeIDs.contains(recipe.id) ? Color.orange500 : Color.gray300,
                                lineWidth: selectedRecipeIDs.contains(recipe.id) ? 2 : 1
                            )
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 14) {
            primaryButton(title: "立即开锅！", systemImage: "flame.fill") {
                onCook(selectedRecipes)
            }

            secondaryButton(
                title: "收进菜谱库",
                systemImage: "book.fill",
                background: Color.white,
                foreground: Color.orange600,
                isDisabled: false
            ) {
                onSave(selectedRecipes)
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


