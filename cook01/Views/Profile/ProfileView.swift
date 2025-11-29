import SwiftUI

struct ProfileView: View {
    let stats: [ProfileStat] = MockData.profileStats
    let recent: [RecentCook] = MockData.recentCooking
    let menu: [ProfileMenuItem] = MockData.profileMenu

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: UIStyle.Profile.sectionSpacing) {
                avatarSection
                statsGrid
                frequentRecipes
                menuList
                achievements
                versionInfo
            }
            .padding(.horizontal, UIStyle.Padding.lg)
            .padding(.top, UIStyle.Padding.xxl)
            .padding(.bottom, UIStyle.Padding.bottomForNavigation)
        }
    }

    private var avatarSection: some View {
        VStack(spacing: UIStyle.Profile.avatarSpacing) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color.orange500)
                    .frame(width: UIStyle.Profile.avatarSize, height: UIStyle.Profile.avatarSize)
                    .overlay(
                        Text("🧑‍🍳")
                            .font(.system(size: UIStyle.Button.iconSizeLarge))
                    )

                Circle()
                    .fill(Color.darkRed)
                    .frame(width: UIStyle.Profile.avatarBadgeSize, height: UIStyle.Profile.avatarBadgeSize)
                    .overlay(
                        Image(systemName: "rosette")
                            .font(.caption.bold())
                            .foregroundStyle(Color.white)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: UIStyle.Profile.avatarBadgeBorderWidth)
                    )
                    .offset(x: UIStyle.Spacing.xs + 2, y: UIStyle.Spacing.xs + 2)
            }

            Text("美食探索者")
                .font(.title2.bold())
                .foregroundStyle(Color.gray800)
            Text("烹饪让生活更有趣 🌟")
                .foregroundStyle(Color.gray600)
        }
        .frame(maxWidth: .infinity)
    }

    private var statsGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: UIStyle.Profile.statsGridSpacing), count: UIStyle.Profile.statsGridColumns), spacing: UIStyle.Profile.statsGridSpacing) {
            ForEach(stats) { stat in
                VStack(spacing: UIStyle.Spacing.sm + 2) {
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.medium, style: .continuous)
                        .fill(stat.colors.first ?? Color.orange500)
                        .frame(width: UIStyle.Profile.statsIconContainerSize, height: UIStyle.Profile.statsIconContainerSize)
                        .overlay(
                            Image(systemName: stat.iconName)
                                .font(.system(size: UIStyle.Profile.statsIconSize, weight: .semibold))
                                .foregroundStyle(Color.white)
                        )

                    Text(stat.value)
                        .font(.title3.bold())
                        .foregroundStyle(Color.gray800)
                    Text(stat.label)
                        .font(.caption)
                        .foregroundStyle(Color.gray500)
                }
                .padding(UIStyle.Profile.statsPadding)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                        .stroke(Color.gray300, lineWidth: UIStyle.Border.width)
                )
            }
        }
    }

    private var frequentRecipes: some View {
        VStack(alignment: .leading, spacing: UIStyle.Spacing.lg) {
            HStack {
                Text("常做菜谱")
                    .font(.title3.bold())
                    .foregroundStyle(Color.gray800)
                Spacer()
                Text("⭐️")
            }

            VStack(spacing: UIStyle.Spacing.md) {
                ForEach(recent) { recipe in
                    HStack {
                        VStack(alignment: .leading, spacing: UIStyle.Spacing.xs) {
                            Text(recipe.name)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.gray800)
                            Text("已做 \(recipe.times) 次 · \(recipe.lastCooked)")
                                .font(.caption)
                                .foregroundStyle(Color.gray500)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(Color.gray400)
                    }
                    .padding(.horizontal, UIStyle.Padding.lg)
                    .padding(.vertical, UIStyle.Spacing.md)
                    .background(Color.orange50)
                    .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous))
                }
            }
        }
        .padding(UIStyle.Padding.xl)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous)
                .stroke(Color.orange100, lineWidth: UIStyle.Border.widthThick)
        )
    }

    private var menuList: some View {
        VStack(spacing: 0) {
            ForEach(menu) { item in
                Button {
                } label: {
                    HStack {
                        HStack(spacing: UIStyle.Padding.md + 2) {
                            RoundedRectangle(cornerRadius: UIStyle.CornerRadius.medium + 2, style: .continuous)
                                .fill(Color.orange50)
                                .frame(width: UIStyle.Profile.statsIconContainerSize, height: UIStyle.Profile.statsIconContainerSize)
                                .overlay(
                                    Image(systemName: item.iconName)
                                        .font(.system(size: UIStyle.Profile.statsIconSize, weight: .medium))
                                        .foregroundStyle(item.tint)
                                )
                            Text(item.label)
                                .font(.body)
                                .foregroundStyle(Color.gray800)
                        }

                        Spacer()

                        if let badge = item.badge {
                            Text(badge)
                                .font(.caption)
                                .padding(.horizontal, UIStyle.Spacing.sm + 2)
                                .padding(.vertical, UIStyle.Spacing.xs + 2)
                                .background(Color.orange100)
                                .foregroundStyle(Color.orange600)
                                .clipShape(Capsule())
                        }

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(Color.gray400)
                    }
                    .padding(.horizontal, UIStyle.Padding.xl)
                    .padding(.vertical, UIStyle.Padding.lg + 2)
                }
                .buttonStyle(.plain)

                if item.id != menu.last?.id {
                    Divider()
                        .padding(.leading, 80)
                        .foregroundStyle(Color.orange100)
                }
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous)
                .stroke(Color.orange100, lineWidth: UIStyle.Border.widthThick)
        )
        .shadow(color: .orange.opacity(0.1), radius: UIStyle.Spacing.sm + 2, y: UIStyle.Spacing.xs + 2)
    }

    private var achievements: some View {
        VStack(alignment: .leading, spacing: UIStyle.Spacing.lg) {
            HStack(spacing: UIStyle.Spacing.md) {
                Text("本周成就")
                    .font(.title3.bold())
                    .foregroundStyle(Color.orange700)
                Text("连续烹饪 5 天！")
                    .font(.subheadline)
                    .foregroundStyle(Color.orange600)
            }

            HStack(spacing: UIStyle.Spacing.md) {
                ForEach(["🥇", "🥈", "🥉", "⭐️", "🎯"], id: \.self) { item in
                    RoundedRectangle(cornerRadius: UIStyle.CornerRadius.large, style: .continuous)
                        .fill(Color.white)
                        .frame(width: UIStyle.Button.iconSizeLarge, height: UIStyle.Button.iconSizeLarge)
                        .shadow(color: .orange.opacity(0.08), radius: UIStyle.Spacing.sm, y: UIStyle.Spacing.xs)
                        .overlay(
                            Text(item)
                                .font(.title2)
                        )
                }
            }
        }
        .padding(UIStyle.Padding.xxl)
        .background(
            LinearGradient(colors: [.orange100, .amber100, .yellow50], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: UIStyle.CornerRadius.extraLarge, style: .continuous)
                .stroke(Color.orange200, lineWidth: UIStyle.Border.widthThick)
        )
    }

    private var versionInfo: some View {
        VStack(spacing: UIStyle.Spacing.xs) {
            Text("煮趣 v1.0.0")
                .font(.caption)
                .foregroundStyle(Color.gray400)
            Text("用心烹饪，用爱调味 💕")
                .font(.caption)
                .foregroundStyle(Color.gray400)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, UIStyle.Spacing.md)
    }
}

