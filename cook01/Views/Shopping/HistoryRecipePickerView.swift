import SwiftUI

struct HistoryRecipePickerView: View {
    let appState: AppState
    let onCancel: () -> Void
    let onConfirm: ([Recipe]) -> Void

    @State private var selectedIds: Set<UUID> = []

    private var allRecipes: [Recipe] {
        appState.linkHistory.flatMap { $0.result.recipes }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(allRecipes) { recipe in
                    Button {
                        toggle(recipe)
                    } label: {
                        HStack(spacing: 12) {
                            AsyncImage(url: recipe.imageURL) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().scaledToFill()
                                case .failure:
                                    Color.orange100
                                case .empty:
                                    ProgressView()
                                @unknown default:
                                    Color.orange100
                                }
                            }
                            .frame(width: 56, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(recipe.name)
                                    .foregroundStyle(Color.gray800)
                                Text("\(recipe.time) · \(recipe.servings)")
                                    .font(.caption)
                                    .foregroundStyle(Color.gray500)
                            }
                            Spacer()
                            Image(systemName: selectedIds.contains(recipe.id) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(selectedIds.contains(recipe.id) ? Color.orange500 : Color.gray300)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("选择要添加的菜谱")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("添加") {
                        let picked = allRecipes.filter { selectedIds.contains($0.id) }
                        onConfirm(picked)
                    }
                    .disabled(selectedIds.isEmpty)
                }
            }
        }
    }

    private func toggle(_ recipe: Recipe) {
        if selectedIds.contains(recipe.id) {
            selectedIds.remove(recipe.id)
        } else {
            selectedIds.insert(recipe.id)
        }
    }
}


