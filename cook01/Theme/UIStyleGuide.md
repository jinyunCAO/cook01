# UI样式调整指南

本文档说明如何精细化调整应用内每个页面的尺寸、颜色等细节。

## 📁 文件位置

所有样式常量都定义在：`cook01/Theme/UIStyle.swift`

## 🎨 如何调整样式

### 1. 打开样式文件

在 Xcode 中打开 `cook01/Theme/UIStyle.swift`

### 2. 找到对应的样式常量

样式按页面和组件分类，结构如下：

```
UIStyle
├── CornerRadius        # 圆角半径
├── Spacing            # 元素间距
├── Padding            # 内边距
├── FontSize           # 字体大小
├── Button             # 按钮尺寸
├── BottomBar          # 底部导航栏
├── Cooking            # 烹饪页面
├── Home               # 首页
├── RecipeGridCard     # 首页食谱卡片
├── Shopping           # 购物清单页面
├── RecipeDetail       # 详情页
├── Profile            # 个人资料页面
├── Shadow             # 阴影效果
├── Animation          # 动画参数
├── Border             # 边框宽度
├── Image              # 图片尺寸
└── Line               # 行间距
```

## 📐 各页面样式调整示例

### 首页 (Home)

**调整头像大小：**
```swift
struct Home {
    static let avatarSize: CGFloat = 56  // 改为你想要的值，如 64
}
```

**调整问候文本字体：**
```swift
struct Home {
    static let greetingTitleSize: CGFloat = 17  // 标题字体大小
    static let greetingSubtitleSize: CGFloat = 13  // 副标题字体大小
}
```

**调整导入卡片样式：**
```swift
struct Home {
    static let importCardPaddingH: CGFloat = 16  // 水平内边距
    static let importCardPaddingV: CGFloat = 14  // 垂直内边距
    static let importCardCornerRadius: CGFloat = 50  // 圆角半径
}
```

**调整食谱网格间距：**
```swift
struct Home {
    static let gridSpacing: CGFloat = 12  // 卡片之间的间距
    static let gridColumns: Int = 2  // 列数（2列或3列）
}
```

### 烹饪页面 (Cooking)

**调整步骤图片高度：**
```swift
struct Cooking {
    static let recipeImageHeight: CGFloat = 240  // 改为 280 等
}
```

**调整步骤文字大小：**
```swift
struct Cooking {
    static let stepTextSize: CGFloat = 21  // 当前是 body + 4pt
    static let stepTextWeight: Font.Weight = .bold  // 可改为 .semibold
}
```

**调整控制按钮：**
```swift
struct Cooking {
    static let controlButtonSize: CGFloat = 56  // 按钮大小
    static let controlButtonSpacing: CGFloat = 32  // 按钮间距
    static let controlButtonCornerRadius: CGFloat = 12  // 播放按钮圆角
}
```

**调整计时器：**
```swift
struct Cooking {
    static let timerSize: CGFloat = 72  // 计时器字体大小
    static let timerHeight: CGFloat = 100  // 计时器容器高度
}
```

### 购物清单页面 (Shopping)

**调整卡片内边距：**
```swift
struct Shopping {
    static let cardPadding: CGFloat = 20  // 卡片内边距
    static let cardSpacing: CGFloat = 16  // 卡片内元素间距
}
```

**调整复选框大小：**
```swift
struct Shopping {
    static let checkboxSize: CGFloat = 28  // 复选框大小
    static let checkboxBorderWidth: CGFloat = 2  // 边框宽度
}
```

### 详情页 (RecipeDetail)

**调整主图高度：**
```swift
struct RecipeDetail {
    static let heroImageHeight: CGFloat = 260  // 主图高度
    static let heroPadding: CGFloat = 20  // 信息卡片内边距
}
```

### 个人资料页面 (Profile)

**调整头像和徽章：**
```swift
struct Profile {
    static let avatarSize: CGFloat = 120  // 头像大小
    static let avatarBadgeSize: CGFloat = 38  // 徽章大小
}
```

**调整统计网格：**
```swift
struct Profile {
    static let statsGridColumns: Int = 3  // 列数
    static let statsGridSpacing: CGFloat = 12  // 间距
}
```

### 底部导航栏 (BottomBar)

**调整图标和激活状态：**
```swift
struct BottomBar {
    static let iconSize: CGFloat = 22  // 图标大小
    static let activeCircleSize: CGFloat = 48  // 激活状态圆形背景大小
    static let horizontalPadding: CGFloat = 32  // 水平内边距
    static let cornerRadius: CGFloat = 50  // 胶囊形状圆角
}
```

## 🎨 颜色调整

颜色定义在：`cook01/Theme/Color+Theme.swift`

### 主题色调整

**主红色（按钮、进度条、选中状态）：**
```swift
static let darkRed = Color(hex: 0x7C0013)  // 改为你想要的十六进制颜色值
```

**红色色阶（用于不同场景）：**
```swift
static let orange500 = Color(hex: 0x7C0013)  // 主红色（与darkRed一致）
static let orange600 = Color(hex: 0xDC2626)  // 深红
static let orange700 = Color(hex: 0xB91C1C)  // 更深红
static let orange400 = Color(hex: 0xF87171)  // 中等红
static let orange300 = Color(hex: 0xFCA5A5)  // 浅红强调
static let orange200 = Color(hex: 0xFECACA)  // 浅红边框
static let orange100 = Color(hex: 0xFEE2E2)  // 浅红背景
static let orange50  = Color(hex: 0xFEF2F2)   // 最浅红背景
```

### 灰色系调整

**背景和边框：**
```swift
static let gray200 = Color(hex: 0xE5E7EB)  // 浅灰背景（卡片背景）
static let gray300 = Color(hex: 0xD1D5DB)  // 边框颜色
```

**文字颜色：**
```swift
static let gray400 = Color(hex: 0x9CA3AF)  // 次要文字、图标
static let gray500 = Color(hex: 0x6B7280)  // 辅助文字
static let gray600 = Color(hex: 0x4B5563)  // 次要标题
static let gray700 = Color(hex: 0x374151)  // 次要内容
static let gray800 = Color(hex: 0x1F2937)  // 主要文字、标题
```

### 特殊颜色

**搜索框背景：**
```swift
static let searchBackground = Color(hex: 0xF8F8F8)  // 搜索框、输入框背景
```

### 颜色值格式

颜色使用十六进制格式，例如：
- `0x7C0013` = RGB(124, 0, 19) = 深红色
- `0xF8F8F8` = RGB(248, 248, 248) = 浅灰色

**如何转换颜色：**
1. 在 Photoshop/Sketch 等设计工具中获取 RGB 值
2. 转换为十六进制：`RGB(124, 0, 19)` → `0x7C0013`
3. 或使用在线工具：https://www.rgbtohex.net/

## 🔄 通用样式调整

### 圆角半径
```swift
struct CornerRadius {
    static let small: CGFloat = 8      // 小按钮、小卡片
    static let medium: CGFloat = 12    // 中等按钮
    static let large: CGFloat = 16     // 主要卡片（最常用）
    static let extraLarge: CGFloat = 28
    static let maximum: CGFloat = 50    // 导航栏胶囊
}
```

### 间距
```swift
struct Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
}
```

### 字体大小
```swift
struct FontSize {
    static let caption: CGFloat = 12
    static let footnote: CGFloat = 13
    static let subheadline: CGFloat = 15
    static let body: CGFloat = 17
    static let bodyLarge: CGFloat = 21
    static let title3: CGFloat = 20
    static let title2: CGFloat = 22
    static let title1: CGFloat = 28
}
```

## ⚡ 性能优化说明

- 所有常量都是 `static let`，编译时优化，零运行时开销
- 使用结构体嵌套组织，便于查找和维护
- 修改后需要重新编译，Xcode 会自动应用更改

## 📝 调整流程

1. **确定要调整的页面/组件**
   - 找到对应的样式结构（如 `UIStyle.Home`）

2. **修改常量值**
   - 在 `UIStyle.swift` 中找到对应常量
   - 修改数值

3. **重新编译运行**
   - 按 `Cmd + R` 运行应用
   - 查看效果

4. **微调**
   - 根据视觉效果继续调整
   - 所有相关组件会自动应用新样式

## 💡 提示

- **保持一致性**：相同类型的元素使用相同的样式常量
- **渐进调整**：一次调整一个值，便于观察效果
- **记录更改**：如果做了重要调整，可以在代码注释中记录原因
- **测试不同设备**：调整后在不同屏幕尺寸的设备上测试

## 🔍 快速查找

如果不知道某个样式在哪里，可以：
1. 在 Xcode 中按 `Cmd + Shift + F` 搜索
2. 搜索硬编码的数值（如 `56`、`16`）
3. 查看对应的 View 文件，找到使用的样式常量

---

**需要帮助？** 查看具体页面的 View 文件，找到使用的 `UIStyle` 常量即可。

