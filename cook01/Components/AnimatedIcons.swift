import SwiftUI

struct SparkleIcon: View {
    @State private var animate = false

    var body: some View {
        Image(systemName: "sparkles")
            .font(.title2)
            .foregroundStyle(Color.amber500)
            .rotationEffect(.degrees(animate ? 10 : -10))
            .animation(
                .easeInOut(duration: 2).repeatForever(autoreverses: true),
                value: animate
            )
            .onAppear {
                animate = true
            }
    }
}

struct AnimatedCartIcon: View {
    @State private var bounce = false

    var body: some View {
        Image(systemName: "cart.fill")
            .font(.title3)
            .foregroundStyle(Color.orange500)
            .rotationEffect(.degrees(bounce ? -8 : 8))
            .animation(
                .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                value: bounce
            )
            .onAppear {
                bounce = true
            }
    }
}

