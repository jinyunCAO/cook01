import SwiftUI

struct CompletionCelebrationView: View {
    let recipeName: String
    let onClose: () -> Void

    @State private var emojiRotate = false

    var body: some View {
        ZStack {
            Color.gray200.opacity(0.2)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    celebrationHeader
                    statsCard
                    achievementCard
                    actions
                    footer
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
                .padding(.bottom, 40)
            }
        }
    }

    private var celebrationHeader: some View {
        VStack(spacing: 12) {
            Text("🎉")
                .font(.system(size: 96))
                .rotationEffect(.degrees(emojiRotate ? 10 : -10))
                .animation(
                    .easeInOut(duration: 1).repeatForever(autoreverses: true),
                    value: emojiRotate
                )
                .onAppear {
                    emojiRotate = true
                }
            Text("烹饪完成！")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.gray800)
            Text(randomEncouragement())
                .font(.title3)
                .foregroundStyle(Color.gray600)
        }
    }

    private var statsCard: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Circle()
                    .fill(Color.orange500)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(Color.white)
                    )
                    .rotationEffect(.degrees(emojiRotate ? 360 : 0))
                    .animation(
                        .easeInOut(duration: 2).repeatForever(autoreverses: false),
                        value: emojiRotate
                    )

                Text(recipeName)
                    .font(.title2.bold())
                    .foregroundStyle(Color.gray800)
                Text("用时 \(Int(MockData.tomatoEgg.steps.reduce(0) { $0 + $1.duration }) / 60) 分钟")
                    .foregroundStyle(Color.gray600)
            }

            HStack(spacing: 14) {
                statBubble(value: "+1", label: "完成次数", color: .orange600)
                statBubble(value: "+10", label: "经验值", color: .amber500)
                statBubble(value: "⭐️", label: "新成就", color: .yellow50)
            }
        }
        .padding(28)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    private var achievementCard: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.orange500)
                .frame(width: 64, height: 64)
                .overlay(
                    Image(systemName: "award.fill")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text("🏆 解锁新成就")
                    .font(.headline)
                    .foregroundStyle(Color.orange700)
                Text("家常菜高手")
                    .font(.title3.bold())
                    .foregroundStyle(Color.orange900)
            }
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }

    private var actions: some View {
        VStack(spacing: 16) {
            Button {
                // 分享逻辑占位
            } label: {
                Text("分享我的成果 ✨")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.orange500)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)

            Button {
                onClose()
            } label: {
                Text("继续探索更多菜谱")
                    .font(.headline)
                    .foregroundStyle(Color.orange700)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
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

    private var footer: some View {
        Text("🍳 美食之旅还在继续...")
            .font(.callout)
            .foregroundStyle(Color.gray600)
    }

    private func randomEncouragement() -> String {
        ["做得太棒了！", "又解锁了一道美味！", "你的厨艺越来越好了！", "完美的烹饪体验！"].randomElement() ?? "做得太棒了！"
    }

    private func statBubble(value: String, label: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(color)
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.gray600)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(color.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

