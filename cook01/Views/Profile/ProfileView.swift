import SwiftUI

struct ProfileView: View {
    let stats: [ProfileStat] = MockData.profileStats
    let recent: [RecentCook] = MockData.recentCooking
    let menu: [ProfileMenuItem] = MockData.profileMenu

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                avatarSection
                statsGrid
                frequentRecipes
                menuList
                achievements
                versionInfo
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 40)
        }
    }

    private var avatarSection: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color.orange500)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Text("🧑‍🍳")
                            .font(.system(size: 48))
                    )

                Circle()
                    .fill(Color.green400)
                    .frame(width: 38, height: 38)
                    .overlay(
                        Image(systemName: "rosette")
                            .font(.caption.bold())
                            .foregroundStyle(Color.white)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .offset(x: 6, y: 6)
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
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
            ForEach(stats) { stat in
                VStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(stat.colors.first ?? Color.orange500)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: stat.iconName)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color.white)
                        )

                    Text(stat.value)
                        .font(.title3.bold())
                        .foregroundStyle(Color.gray800)
                    Text(stat.label)
                        .font(.caption)
                        .foregroundStyle(Color.gray500)
                }
                .padding(14)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray300, lineWidth: 1)
                )
            }
        }
    }

    private var frequentRecipes: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("常做菜谱")
                    .font(.title3.bold())
                    .foregroundStyle(Color.gray800)
                Spacer()
                Text("⭐️")
            }

            VStack(spacing: 12) {
                ForEach(recent) { recipe in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
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
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.orange50)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.orange100, lineWidth: 2)
        )
    }

    private var menuList: some View {
        VStack(spacing: 0) {
            ForEach(menu) { item in
                Button {
                } label: {
                    HStack {
                        HStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color.orange50)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Image(systemName: item.iconName)
                                        .font(.system(size: 18, weight: .medium))
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
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.orange100)
                                .foregroundStyle(Color.orange600)
                                .clipShape(Capsule())
                        }

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(Color.gray400)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
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
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.orange100, lineWidth: 2)
        )
        .shadow(color: .orange.opacity(0.1), radius: 10, y: 6)
    }

    private var achievements: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Text("本周成就")
                    .font(.title3.bold())
                    .foregroundStyle(Color.orange700)
                Text("连续烹饪 5 天！")
                    .font(.subheadline)
                    .foregroundStyle(Color.orange600)
            }

            HStack(spacing: 12) {
                ForEach(["🥇", "🥈", "🥉", "⭐️", "🎯"], id: \.self) { item in
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white)
                        .frame(width: 48, height: 48)
                        .shadow(color: .orange.opacity(0.08), radius: 8, y: 4)
                        .overlay(
                            Text(item)
                                .font(.title2)
                        )
                }
            }
        }
        .padding(24)
        .background(
            LinearGradient(colors: [.orange100, .amber100, .yellow50], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.orange200, lineWidth: 2)
        )
    }

    private var versionInfo: some View {
        VStack(spacing: 4) {
            Text("煮趣 v1.0.0")
                .font(.caption)
                .foregroundStyle(Color.gray400)
            Text("用心烹饪，用爱调味 💕")
                .font(.caption)
                .foregroundStyle(Color.gray400)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}

