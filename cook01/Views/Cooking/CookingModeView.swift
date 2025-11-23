import SwiftUI

struct CookingModeView: View {
    let recipe: Recipe?
    var onExit: () -> Void

    @StateObject private var progress = CookingProgress(steps: MockData.tomatoEgg.steps)
    @State private var voiceEnabled = true

    var body: some View {
        Group {
            if let recipe {
                cookingContent(recipe: recipe)
                    .onAppear {
                        progress.bindTimer()
                    }
            } else {
                cookingEmptyState
            }
        }
        .fullScreenCover(isPresented: $progress.showCompletion) {
            CompletionCelebrationView(
                recipeName: recipe?.name ?? "番茄炒蛋",
                onClose: {
                    progress.showCompletion = false
                    progress.currentIndex = 0
                    progress.completed.removeAll()
                    progress.restartTimerForCurrentStep()
                    progress.isRunning = false
                    onExit()
                }
            )
        }
    }
    
    private var cookingEmptyState: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                Spacer()
                    .frame(height: 100)
                
                VStack(spacing: 24) {
                    Image(systemName: "chef.hat.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(Color.orange500)
                    
                    VStack(spacing: 12) {
                        Text("选择菜谱开始烹饪")
                            .font(.title2.bold())
                            .foregroundStyle(Color.gray800)
                        Text("从首页或菜谱详情页选择一道菜谱\n开始你的烹饪之旅吧！")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray600)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                }
                .padding(40)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray300, lineWidth: 1)
                )
                
                Button {
                    onExit()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.left")
                        Text("返回首页选择菜谱")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .foregroundStyle(Color.white)
                    .background(Color.orange500)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 48)
        }
        .background(Color.gray200.opacity(0.2).ignoresSafeArea())
    }

    private func cookingContent(recipe: Recipe) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                header
                progressBar
                timerCard
                stepPager(recipe: recipe)
                navigationButtons
                indicatorDots
                encouragement
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 48)
        }
        .background(Color.gray200.opacity(0.2).ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("烹饪中")
                    .font(.title2.bold())
                    .foregroundStyle(Color.gray800)
                Text("第 \(progress.currentIndex + 1) / \(progress.steps.count) 步")
                    .foregroundStyle(Color.gray600)
            }
            Spacer()
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    voiceEnabled.toggle()
                }
            } label: {
                Image(systemName: voiceEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    .font(.title3)
                    .foregroundStyle(voiceEnabled ? Color.white : Color.gray400)
                    .frame(width: 52, height: 52)
                    .background(voiceEnabled ? Color.orange500 : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(voiceEnabled ? Color.clear : Color.gray300, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        }
    }

    private var progressBar: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray300)
                Capsule()
                    .fill(Color.orange500)
                    .frame(width: proxy.size.width * progress.progress)
            }
        }
        .frame(height: 8)
        .clipShape(Capsule())
    }

    private var timerCard: some View {
        VStack(spacing: 20) {
            Text(progress.timeLeft.formattedClock)
                .font(.system(size: 56, weight: .heavy, design: .rounded))
                .foregroundStyle(Color.orange600)
                .scaleEffect(progress.isRunning ? 1.05 : 1.0)
                .animation(
                    progress.isRunning ?
                        .easeInOut(duration: 0.9).repeatForever(autoreverses: true) :
                        .default,
                    value: progress.isRunning
                )

            HStack(spacing: 16) {
                Button(progress.isRunning ? "暂停" : "开始计时") {
                    progress.toggleRunning()
                }
                .buttonStyle(PrimaryGradientButtonStyle())

                Button("重置") {
                    progress.restartTimerForCurrentStep()
                    progress.isRunning = false
                }
                .buttonStyle(LightButtonStyle())
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

    private func stepPager(recipe: Recipe) -> some View {
        TabView(selection: $progress.currentIndex) {
            ForEach(Array(recipe.steps.enumerated()), id: \.element.id) { index, step in
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        Circle()
                            .fill(Color.orange500)
                            .frame(width: 56, height: 56)
                            .overlay(
                                Text("\(step.id)")
                                    .font(.title2.bold())
                                    .foregroundStyle(Color.white)
                            )

                        Text(step.description)
                            .font(.headline)
                            .foregroundStyle(Color.gray800)
                    }

                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.amber50)
                        .overlay(
                            Text("💡 小贴士：\(step.tip)")
                                .font(.subheadline)
                                .foregroundStyle(Color.amber700)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        )
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray300, lineWidth: 1)
                )
                .padding(.horizontal, 4)
                .tag(index)
                .animation(.easeInOut, value: progress.currentIndex)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 260)
    }

    private var navigationButtons: some View {
        HStack(spacing: 16) {
            Button {
                progress.previous()
            } label: {
                Label("上一步", systemImage: "chevron.left")
            }
            .buttonStyle(OutlinedButtonStyle(enabled: progress.currentIndex > 0))
            .disabled(progress.currentIndex == 0)

            if progress.isLastStep {
                Button {
                    progress.next()
                } label: {
                    Label("完成烹饪", systemImage: "checkmark")
                }
                .buttonStyle(GreenGradientButtonStyle())
            } else {
                Button {
                    progress.next()
                } label: {
                    Label("完成这步", systemImage: "chevron.right")
                }
                .buttonStyle(PrimaryGradientButtonStyle())
            }
        }
    }

    private var indicatorDots: some View {
        HStack(spacing: 8) {
            ForEach(progress.steps.indices, id: \.self) { index in
                Capsule()
                    .fill(progress.capsuleColor(for: index))
                    .frame(width: progress.capsuleWidth(for: index), height: 8)
                    .animation(.easeInOut(duration: 0.25), value: progress.currentIndex)
            }
        }
    }

    private var encouragement: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.orange100)
            .overlay(
                Text(progress.encouragementText)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.orange700)
                    .padding()
            )
            .frame(height: 84)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.orange300, lineWidth: 1)
            )
    }
}

