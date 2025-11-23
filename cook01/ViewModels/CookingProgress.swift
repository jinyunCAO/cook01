import Foundation
import Combine
import SwiftUI

final class CookingProgress: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var timeLeft: TimeInterval
    @Published var isRunning: Bool = false
    @Published var completed: Set<Int> = []
    @Published var showCompletion: Bool = false

    let steps: [Step]
    private var cancellable: AnyCancellable?

    init(steps: [Step]) {
        self.steps = steps
        self.timeLeft = steps.first?.duration ?? 0
    }

    deinit {
        cancellable?.cancel()
    }

    func bindTimer() {
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                guard self.isRunning, self.timeLeft > 0 else { return }
                self.timeLeft -= 1
            }
    }

    func toggleRunning() {
        isRunning.toggle()
    }

    func restartTimerForCurrentStep() {
        timeLeft = steps[currentIndex].duration
    }

    func next() {
        completed.insert(currentIndex)
        if currentIndex == steps.count - 1 {
            showCompletion = true
        } else {
            currentIndex += 1
            restartTimerForCurrentStep()
            isRunning = false
        }
    }

    func previous() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        restartTimerForCurrentStep()
        isRunning = false
    }

    var progress: Double {
        guard !steps.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(steps.count)
    }

    var isLastStep: Bool {
        currentIndex == steps.count - 1
    }

    func capsuleColor(for index: Int) -> Color {
        if index == currentIndex { return .orange500 }
        if completed.contains(index) { return .green400 }
        return .gray300
    }

    func capsuleWidth(for index: Int) -> CGFloat {
        if index == currentIndex { return 28 }
        return 10
    }

    var encouragementText: String {
        switch currentIndex {
        case 0:
            return "🎉 加油！美味即将诞生~"
        case steps.count - 1:
            return "✨ 最后一步啦！胜利在望~"
        default:
            return "👏 做得很好！继续保持~"
        }
    }
}

