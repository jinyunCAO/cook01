import SwiftUI

struct StepCard: View {
    let step: Step

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.orange500)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Text("\(step.id)")
                            .font(.title3.bold())
                            .foregroundStyle(Color.white)
                    )

                VStack(alignment: .leading, spacing: 8) {
                    Text(step.description)
                        .font(.headline)
                        .foregroundStyle(Color.gray800)

                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.orange600)
                        Text(step.duration.formattedClock)
                            .font(.subheadline)
                            .foregroundStyle(Color.orange600)
                    }
                }
            }

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.amber50)
                .overlay(
                    Text("💡 \(step.tip)")
                        .font(.subheadline)
                        .foregroundStyle(Color.amber700)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }
}

