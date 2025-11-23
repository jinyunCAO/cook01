import Foundation
import SwiftUI

enum MockData {
    static let tomatoEgg = Recipe(
        name: "番茄炒蛋",
        imageURL: URL(string: "https://images.unsplash.com/photo-1608756687911-aa1599ab3bd9?w=800")!,
        description: "最经典的家常菜，酸甜可口，色泽诱人，简单快手却百吃不厌",
        time: "15分钟",
        servings: "2-3人份",
        difficulty: "简单",
        tags: ["家常", "快手"],
        likes: 1243,
        savedAt: "2天前",
        ingredients: [
            Ingredient(name: "鸡蛋", amount: "3个", category: .main),
            Ingredient(name: "番茄", amount: "2个", category: .main),
            Ingredient(name: "小葱", amount: "2根", category: .supplement),
            Ingredient(name: "食用油", amount: "适量", category: .seasoning),
            Ingredient(name: "盐", amount: "1小勺", category: .seasoning),
            Ingredient(name: "白糖", amount: "半小勺", category: .seasoning)
        ],
        steps: [
            Step(id: 1, description: "番茄顶部划十字，放入开水中烫30秒，去皮后切块", duration: 180, tip: "划十字可以更容易去皮哦"),
            Step(id: 2, description: "鸡蛋打入碗中，加少许盐，充分打散至起泡", duration: 120, tip: "打到出现小气泡，炒出来更蓬松"),
            Step(id: 3, description: "热锅凉油，倒入蛋液，快速滑炒至七分熟盛出", duration: 120, tip: "不要炒太老，会影响口感"),
            Step(id: 4, description: "锅中留底油，倒入番茄块翻炒至出汁", duration: 300, tip: "耐心炒出汁水，味道更浓郁"),
            Step(id: 5, description: "倒入炒好的鸡蛋，加盐和糖调味，翻炒均匀即可出锅", duration: 180, tip: "加点糖能提鲜，但不要太多")
        ]
    )

    static let recentRecipes: [Recipe] = [
        tomatoEgg,
        Recipe(
            name: "红烧肉",
            imageURL: URL(string: "https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=400")!,
            description: "软糯香甜的硬菜",
            time: "60分钟",
            servings: "3-4人份",
            difficulty: "中等",
            tags: ["硬菜", "聚餐"],
            likes: 3891,
            savedAt: "5天前",
            ingredients: tomatoEgg.ingredients,
            steps: tomatoEgg.steps
        ),
        Recipe(
            name: "蒜蓉西兰花",
            imageURL: URL(string: "https://images.unsplash.com/photo-1628773822503-930a7eaecf80?w=400")!,
            description: "清爽健康素菜",
            time: "10分钟",
            servings: "2人份",
            difficulty: "简单",
            tags: ["健康", "素食"],
            likes: 567,
            savedAt: "1周前",
            ingredients: tomatoEgg.ingredients,
            steps: tomatoEgg.steps
        )
    ]

    static let recipeItems: [RecipeShoppingItems] = [
        RecipeShoppingItems(
            recipeId: "recipe1",
            recipeName: "番茄炒蛋",
            items: [
                RawShoppingItem(id: 101, name: "鸡蛋", amount: "3个", category: .dairy),
                RawShoppingItem(id: 102, name: "番茄", amount: "2个", category: .vegetable),
                RawShoppingItem(id: 103, name: "小葱", amount: "2根", category: .vegetable),
                RawShoppingItem(id: 104, name: "食用油", amount: "适量", category: .seasoning),
                RawShoppingItem(id: 105, name: "盐", amount: "1小勺", category: .seasoning)
            ]
        ),
        RecipeShoppingItems(
            recipeId: "recipe2",
            recipeName: "蛋炒饭",
            items: [
                RawShoppingItem(id: 201, name: "鸡蛋", amount: "3个", category: .dairy),
                RawShoppingItem(id: 202, name: "米饭", amount: "2碗", category: .staple),
                RawShoppingItem(id: 203, name: "小葱", amount: "1根", category: .vegetable),
                RawShoppingItem(id: 204, name: "食用油", amount: "适量", category: .seasoning),
                RawShoppingItem(id: 205, name: "盐", amount: "少许", category: .seasoning)
            ]
        ),
        RecipeShoppingItems(
            recipeId: "recipe3",
            recipeName: "红烧肉",
            items: [
                RawShoppingItem(id: 301, name: "五花肉", amount: "500g", category: .meat),
                RawShoppingItem(id: 302, name: "冰糖", amount: "30g", category: .seasoning),
                RawShoppingItem(id: 303, name: "酱油", amount: "3勺", category: .seasoning),
                RawShoppingItem(id: 304, name: "料酒", amount: "2勺", category: .seasoning)
            ]
        )
    ]

    static let completedHistory: [Recipe] = [
        Recipe(
            name: "番茄炒蛋",
            imageURL: tomatoEgg.imageURL,
            description: tomatoEgg.description,
            time: tomatoEgg.time,
            servings: tomatoEgg.servings,
            difficulty: tomatoEgg.difficulty,
            tags: tomatoEgg.tags,
            likes: tomatoEgg.likes,
            savedAt: "今天",
            ingredients: tomatoEgg.ingredients,
            steps: tomatoEgg.steps
        ),
        Recipe(
            name: "蛋炒饭",
            imageURL: URL(string: "https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400")!,
            description: "金黄松软，粒粒分明",
            time: "20分钟",
            servings: "2人份",
            difficulty: "简单",
            tags: ["快手", "家常"],
            likes: 2045,
            savedAt: "昨天",
            ingredients: tomatoEgg.ingredients,
            steps: tomatoEgg.steps
        ),
        Recipe(
            name: "红烧肉",
            imageURL: URL(string: "https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=400")!,
            description: "软糯香甜的硬菜",
            time: "60分钟",
            servings: "3-4人份",
            difficulty: "中等",
            tags: ["硬菜", "聚餐"],
            likes: 3891,
            savedAt: "3天前",
            ingredients: tomatoEgg.ingredients,
            steps: tomatoEgg.steps
        ),
        Recipe(
            name: "蒜蓉西兰花",
            imageURL: URL(string: "https://images.unsplash.com/photo-1628773822503-930a7eaecf80?w=400")!,
            description: "清爽健康素菜",
            time: "10分钟",
            servings: "2人份",
            difficulty: "简单",
            tags: ["健康", "素食"],
            likes: 567,
            savedAt: "1周前",
            ingredients: tomatoEgg.ingredients,
            steps: tomatoEgg.steps
        )
    ]

    static let profileStats: [ProfileStat] = [
        ProfileStat(iconName: "book.fill", label: "收藏菜谱", value: "28", colors: [.orange400, .amber500]),
        ProfileStat(iconName: "clock.fill", label: "烹饪时长", value: "12.5h", colors: [.amber400, .yellow50]),
        ProfileStat(iconName: "rosette", label: "完成次数", value: "45", colors: [.yellow50, .orange500])
    ]

    static let recentCooking: [RecentCook] = [
        RecentCook(name: "番茄炒蛋", times: 8, lastCooked: "今天"),
        RecentCook(name: "红烧肉", times: 3, lastCooked: "3天前"),
        RecentCook(name: "蒜蓉西兰花", times: 5, lastCooked: "1周前")
    ]

    static let profileMenu: [ProfileMenuItem] = [
        ProfileMenuItem(iconName: "heart.fill", label: "我的收藏", badge: "28", tint: .red),
        ProfileMenuItem(iconName: "bell.fill", label: "烹饪提醒", badge: nil, tint: .orange),
        ProfileMenuItem(iconName: "paintpalette.fill", label: "主题设置", badge: nil, tint: .orange),
        ProfileMenuItem(iconName: "info.circle.fill", label: "关于煮趣", badge: nil, tint: .gray)
    ]
}

extension MockData {
    static func linkResult(forURL urlString: String) -> LinkImportResult? {
        let candidates = lookupCandidates(for: urlString)
        for key in candidates {
            if let entry = linkImportLookup[key] {
                return LinkImportResult(
                    title: entry.title,
                    coverURL: entry.coverURL,
                    recipes: entry.recipes
                )
            }
        }
        return nil
    }

    static func recipe(forURL urlString: String) -> Recipe? {
        linkResult(forURL: urlString)?.recipes.first
    }

    private static func lookupCandidates(for urlString: String) -> [String] {
        var results: [String] = []
        let trimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !trimmed.isEmpty else { return [] }
        results.append(trimmed)

        if let url = URL(string: trimmed),
           let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let host = components.host?.lowercased() {
                let sanitizedHost = host.replacingOccurrences(of: "www.", with: "")
                results.append(host)
                results.append(sanitizedHost)

                let path = components.path.lowercased()
                if !path.isEmpty {
                    results.append(host + path)
                    results.append(sanitizedHost + path)
                    if path.hasSuffix("/") {
                        let trimmedPath = String(path.dropLast())
                        results.append(host + trimmedPath)
                        results.append(sanitizedHost + trimmedPath)
                    }
                }
            }

            let pathCandidates = url.pathComponents
                .filter { $0 != "/" }
                .reversed()
                .map { $0.lowercased() }
            results.append(contentsOf: pathCandidates)

            if let queryItems = components.queryItems {
                for item in queryItems {
                    if let value = item.value?.lowercased(), !value.isEmpty {
                        results.append(value)
                    }
                }
            }
        }

        var seen = Set<String>()
        return results.compactMap { candidate in
            guard !candidate.isEmpty else { return nil }
            if seen.insert(candidate).inserted {
                return candidate
            } else {
                return nil
            }
        }
    }

    private struct LinkImportEntry {
        let title: String
        let coverURL: URL
        let recipes: [Recipe]
    }

    private static let linkImportLookup: [String: LinkImportEntry] = {
        var mapping: [String: LinkImportEntry] = [:]

        func register(_ keys: [String], title: String, coverURL: URL, recipes: [Recipe]) {
            let entry = LinkImportEntry(title: title, coverURL: coverURL, recipes: recipes)
            for key in keys {
                mapping[key.lowercased()] = entry
            }
        }

        let tomatoBundle = [tomatoEgg] + Array(recentRecipes.dropFirst().prefix(1))

        register(
            [
                "tomato-egg",
                "fanqiechaodan",
                "recipe1",
                "xiaohongshu.com/explore/tomato-egg",
                "www.xiaohongshu.com/explore/tomato-egg"
            ],
            title: "小红书 · 快手番茄炒蛋合集",
            coverURL: URL(string: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800") ?? tomatoEgg.imageURL,
            recipes: tomatoBundle
        )

        if let braisedPork = recentRecipes.first(where: { $0.name == "红烧肉" }) {
            register(
                [
                    "hongshaorou",
                    "hong-shao-rou",
                    "recipe2",
                    "xiaohongshu.com/explore/hong-shao-rou",
                    "www.xiaohongshu.com/explore/hong-shao-rou"
                ],
                title: "小红书 · 家常红烧肉",
                coverURL: URL(string: "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?w=800") ?? braisedPork.imageURL,
                recipes: [braisedPork]
            )
        }

        if let broccoli = recentRecipes.first(where: { $0.name == "蒜蓉西兰花" }) {
            register(
                [
                    "suanrongxilanhua",
                    "garlic-broccoli",
                    "recipe3",
                    "xiaohongshu.com/explore/garlic-broccoli",
                    "www.xiaohongshu.com/explore/garlic-broccoli"
                ],
                title: "小红书 · 蒜蓉西兰花零失败",
                coverURL: URL(string: "https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=800") ?? broccoli.imageURL,
                recipes: [broccoli]
            )
        }

        if let friedRice = completedHistory.first(where: { $0.name == "蛋炒饭" }) {
            register(
                [
                    "danchao fan",
                    "danchaofan",
                    "egg-fried-rice"
                ],
                title: "小红书 · 金黄蛋炒饭",
                coverURL: URL(string: "https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800") ?? friedRice.imageURL,
                recipes: [friedRice]
            )
        }

        return mapping
    }()
}

