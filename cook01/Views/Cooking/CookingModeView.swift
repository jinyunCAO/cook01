import SwiftUI

struct CookingModeView: View {
    let recipe: Recipe?
    var onExit: () -> Void

    @StateObject private var progress: CookingProgress
    @State private var voiceEnabled = true

    init(recipe: Recipe?, onExit: @escaping () -> Void) {
        self.recipe = recipe
        self.onExit = onExit
        _progress = StateObject(wrappedValue: CookingProgress(steps: recipe?.steps ?? []))
    }

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
        .id(recipe?.id)
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
                
                VStack(spacing: UIStyle.Cooking.contentSpacing) {
                    Image(systemName: "chef.hat.fill")
                        .font(.system(size: UIStyle.Image.emptyStateIcon))
                        .foregroundStyle(Color.orange500)
                    
                    VStack(spacing: UIStyle.Spacing.md) {
                        Text("选择菜谱开始烹饪")
                            .font(.title2.bold())
                            .foregroundStyle(Color.gray800)
                        Text("从首页或菜谱详情页选择一道菜谱\n开始你的烹饪之旅吧！")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray600)
                            .multilineTextAlignment(.center)
                            .lineSpacing(UIStyle.Line.spacingSmall)
                    }
                }
                .padding(UIStyle.Padding.xxxl)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                        .stroke(Color.gray300, lineWidth: UIStyle.Border.width)
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
                    .padding(.vertical, UIStyle.Padding.lg)
                    .foregroundStyle(Color.white)
                    .background(Color.orange500)
                    .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, UIStyle.Padding.xl)
                
                Spacer()
            }
            .padding(.horizontal, UIStyle.Padding.xl)
            .padding(.top, UIStyle.Padding.xxxl)
            .padding(.bottom, UIStyle.Padding.bottomForNavigation)
        }
        .background(Color.gray200.opacity(0.2).ignoresSafeArea())
    }

    private func cookingContent(recipe: Recipe) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: UIStyle.Cooking.contentSpacing) {
                header(recipe: recipe)
                stepContent(recipe: recipe)
                timerSection
                controlButtons
            }
            .padding(.horizontal, UIStyle.Padding.xl)
            .padding(.top, UIStyle.Padding.lg)
            .padding(.bottom, UIStyle.Padding.bottomForNavigation)
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func header(recipe: Recipe) -> some View {
        VStack(spacing: UIStyle.Cooking.headerSpacing) {
        HStack {
                Text(recipe.name)
                    .font(.title2.bold())
                    .foregroundStyle(Color.gray800)
            Spacer()
            Button {
                    withAnimation(.spring(response: UIStyle.Animation.springResponse, dampingFraction: UIStyle.Animation.springDamping)) {
                    voiceEnabled.toggle()
                }
            } label: {
                Image(systemName: voiceEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill")
                        .font(.system(size: UIStyle.Button.iconSizeSmall, weight: .medium))
                        .foregroundStyle(Color.white)
                        .frame(width: UIStyle.Cooking.voiceButtonSize, height: UIStyle.Cooking.voiceButtonSize)
                        .background(Color.darkRed)
                        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.small, style: .continuous))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, UIStyle.Spacing.xs)
            
            // 进度条
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray300.opacity(0.3))
                        .frame(height: UIStyle.Cooking.progressBarHeight)
                    Capsule()
                        .fill(Color.darkRed)
                        .frame(width: proxy.size.width * progress.progress, height: UIStyle.Cooking.progressBarHeight)
                }
            }
            .frame(height: UIStyle.Cooking.progressBarHeight)
        }
    }

    private func stepContent(recipe: Recipe) -> some View {
        let currentStep = recipe.steps[progress.currentIndex]
        
        return VStack(spacing: UIStyle.Cooking.contentSpacing) {
            // 步骤图片
            AsyncImage(url: recipe.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_), .empty:
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                        .fill(Color.gray200)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: UIStyle.Button.iconSizeLarge))
                                .foregroundStyle(Color.gray400)
                        )
                @unknown default:
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                        .fill(Color.gray200)
                }
            }
            .frame(height: UIStyle.Cooking.recipeImageHeight)
            .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                    .stroke(Color.gray300, lineWidth: UIStyle.Border.width)
            )
            
            // 步骤说明
            Text(currentStep.description)
                .font(.system(size: UIStyle.Cooking.stepTextSize, weight: UIStyle.Cooking.stepTextWeight))
                .foregroundStyle(Color.gray800)
                .multilineTextAlignment(.center)
                .lineSpacing(UIStyle.Line.spacing)
                .padding(.horizontal, UIStyle.Padding.lg)
        }
    }

    private var timerSection: some View {
        VStack(spacing: 0) {
            Text(progress.timeLeft.formattedClock)
                .font(.system(size: UIStyle.Cooking.timerSize, weight: .heavy, design: .rounded))
                .foregroundStyle(Color.darkRed)
                .scaleEffect(progress.isRunning ? 1.05 : 1.0)
                .animation(
                    progress.isRunning ?
                        .easeInOut(duration: UIStyle.Animation.timerPulseDuration).repeatForever(autoreverses: true) :
                        .default,
                    value: progress.isRunning
                )
        }
        .frame(height: UIStyle.Cooking.timerHeight)
            }

    private var controlButtons: some View {
        HStack(spacing: UIStyle.Cooking.controlButtonSpacing) {
            // 播放/暂停按钮 - 深红色方形，带圆角
            Button {
                    progress.toggleRunning()
            } label: {
                Image(systemName: progress.isRunning ? "pause.fill" : "play.fill")
                    .font(.title2)
                                    .foregroundStyle(Color.white)
                    .frame(width: UIStyle.Cooking.controlButtonSize, height: UIStyle.Cooking.controlButtonSize)
                    .background(Color.darkRed)
                    .clipShape(RoundedRectangle(cornerRadius: UIStyle.Cooking.controlButtonCornerRadius, style: .continuous))
            }
            .buttonStyle(.plain)
            
            // 重置按钮 - 灰色圆形
            Button {
                progress.restartTimerForCurrentStep()
                progress.isRunning = false
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .frame(width: UIStyle.Cooking.controlButtonSize, height: UIStyle.Cooking.controlButtonSize)
                    .background(Color.gray200)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)

            // 下一步按钮 - 灰色圆形，使用快进图标
                Button {
                    progress.next()
                } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .frame(width: UIStyle.Cooking.controlButtonSize, height: UIStyle.Cooking.controlButtonSize)
                    .background(Color.gray200)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.top, UIStyle.Spacing.sm)
    }
}

