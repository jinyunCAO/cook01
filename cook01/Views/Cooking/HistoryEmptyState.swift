import SwiftUI

struct HistoryEmptyState: View {
    let onImport: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                header
                achievementCard
                historyList
                importCallToAction
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 48)
        }
        .background(
            LinearGradient(
                colors: [.orange50, .amber50, .red50],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text("烹饪成就")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.gray800)
            Text("已完成 \(MockData.completedHistory.count * 5) 道美味佳肴")
                .foregroundStyle(Color.gray600)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var achievementCard: some View {
        VStack(spacing: 20) {
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(
                        LinearGradient(colors: [.orange400, .amber500], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 64, height: 64)
                    .overlay(
                        Image(systemName: "rosette")
                            .font(.title2.bold())
                            .foregroundStyle(Color.white)
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text("烹饪大师")
                        .font(.title3.bold())
                        .foregroundStyle(Color.gray800)
                    Text("继续加油，解锁更多成就！")
                        .foregroundStyle(Color.gray600)
                }

                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("升级进度")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray600)
                    Spacer()
                    Text("\(MockData.completedHistory.count)/50")
                        .font(.subheadline)
                        .foregroundStyle(Color.orange600)
                }

                GeometryReader { proxy in
                    Capsule()
                        .fill(Color.orange100)
                        .overlay(
                            Capsule()
                                .fill(
                                    LinearGradient(colors: [.orange400, .amber500], startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(width: proxy.size.width * Double(MockData.completedHistory.count) / 50.0)
                        )
                }
                .frame(height: 10)
            }

            HStack(spacing: 12) {
                ForEach(["🥇", "🥈", "🥉", "⭐️", "🏆"], id: \.self) { badge in
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.orange50)
                        .frame(width: 48, height: 48)
                        .overlay(
                            Text(badge)
                                .font(.title2)
                        )
                }
            }
        }
        .padding(24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(Color.orange200, lineWidth: 2)
        )
        .shadow(color: .orange.opacity(0.16), radius: 18, y: 12)
    }

    private var historyList: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("完成记录")
                    .font(.title3.bold())
                    .foregroundStyle(Color.gray800)
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundStyle(Color.orange500)
            }

            VStack(spacing: 12) {
                ForEach(MockData.completedHistory) { recipe in
                    HStack(spacing: 16) {
                        AsyncImage(url: recipe.imageURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure(_):
                                Color.orange100
                            case .empty:
                                ProgressView()
                            @unknown default:
                                Color.orange100
                            }
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(recipe.name)
                                .font(.headline)
                                .foregroundStyle(Color.gray800)
                            Text("完成 \(Int.random(in: 1...12)) 次 · 最近 \(recipe.savedAt ?? "未知")")
                                .font(.caption)
                                .foregroundStyle(Color.gray600)
                        }

                        Spacer()
                    }
                    .padding(16)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(Color.orange100, lineWidth: 2)
                    )
                    .shadow(color: .orange.opacity(0.12), radius: 12, y: 8)
                }
            }
        }
    }

    private var importCallToAction: some View {
        VStack(spacing: 12) {
            Text("准备开始新的烹饪？")
                .font(.title3.bold())
                .foregroundStyle(Color.gray800)
            Text("导入菜谱，开始你的美食创作之旅")
                .foregroundStyle(Color.gray600)

            Button {
                onImport()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "plus.circle.fill")
                    Text("导入新菜谱")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(Color.white)
                .background(
                    LinearGradient(colors: [.orange500, .amber500], startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: .orange.opacity(0.3), radius: 14, y: 10)
            }
            .buttonStyle(.plain)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(
                    LinearGradient(colors: [.orange100, .amber100], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(Color.orange300, style: StrokeStyle(lineWidth: 2, dash: [8, 6]))
        )
    }
}

