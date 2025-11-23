import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            colors: [.orange50, .amber50, .yellow50],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

