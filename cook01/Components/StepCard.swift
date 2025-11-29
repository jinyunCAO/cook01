import SwiftUI

struct StepCard: View {
    let step: Step

    var body: some View {
        HStack(alignment: .top, spacing: UIStyle.Spacing.lg) {
            // 左侧深红色圆形数字图标（尺寸调小）
                Circle()
                .fill(Color.darkRed)
                .frame(width: 36, height: 36)
                    .overlay(
                        Text("\(step.id)")
                        .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.white)
                    )

            // 右侧内容
            VStack(alignment: .leading, spacing: UIStyle.Spacing.sm) {
                // 步骤描述
                    Text(step.description)
                        .font(.headline)
                        .foregroundStyle(Color.gray800)
                    .fixedSize(horizontal: false, vertical: true)

                // 时间信息
                HStack(spacing: UIStyle.Spacing.xs + 2) {
                        Image(systemName: "clock")
                        .font(.caption)
                        .foregroundStyle(Color.darkRed)
                        Text(step.duration.formattedClock)
                            .font(.subheadline)
                        .foregroundStyle(Color.darkRed)
                    }
                }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(UIStyle.Padding.lg)
        .background(Color.gray200.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
    }
}

