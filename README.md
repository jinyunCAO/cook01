# Cook01 - 智能烹饪助手 iOS 应用

## 📱 项目简介

Cook01 是一款基于 SwiftUI 开发的智能烹饪助手 iOS 应用，提供菜谱浏览、烹饪步骤指导、购物清单管理等功能。应用采用现代化的 UI 设计，支持从链接导入菜谱，并提供实时烹饪计时功能。

## ✨ 核心功能

### 1. 首页 (Home)
- **用户头像和问候语**：个性化欢迎界面
- **链接导入功能**：支持从小红书等平台导入菜谱链接
- **菜谱历史记录**：网格布局展示已保存的菜谱
- **右滑删除**：支持手势操作删除菜谱

### 2. 菜谱详情页 (Recipe Detail)
- **预览大图**：高清菜谱封面展示
- **基本信息**：烹饪时间、份量、难度等
- **食材清单**：分类展示所需食材
- **烹饪步骤**：详细的步骤说明，带计时功能
- **快速操作**：一键收藏到菜谱库、立即开始烹饪

### 3. 烹饪模式 (Cooking Mode)
- **步骤导航**：清晰的步骤指示和进度显示
- **计时器功能**：每个步骤的倒计时
- **进度条**：可视化烹饪进度
- **语音播报**：可选的语音提示功能
- **完成庆祝**：烹饪完成后的动画反馈

### 4. 购物清单 (Shopping List)
- **智能合并**：自动合并相同食材
- **分类管理**：按类别组织购物清单
- **完成标记**：勾选已购买的食材

### 5. 个人中心 (Profile)
- **用户信息**：头像、昵称展示
- **统计数据**：烹饪次数、收藏数等
- **成就系统**：烹饪成就展示
- **设置选项**：应用设置和关于信息

## 🎨 UI 设计特色

### 设计系统
- **主题色**：深红色 (`#7C0013`) 作为主色调
- **圆角设计**：统一的圆角半径系统
- **毛玻璃效果**：底部导航栏采用半透明毛玻璃材质
- **卡片式布局**：现代化的卡片设计语言

### 样式系统 (UIStyle)
项目采用集中式样式管理系统，所有 UI 尺寸、间距、字体等都在 `UIStyle.swift` 中统一管理：

```swift
// 示例：调整头像尺寸
UIStyle.Home.avatarSize = 80

// 示例：调整按钮高度
UIStyle.Button.height = 56
```

详细的使用指南请参考：`cook01/Theme/UIStyleGuide.md`

## 🏗️ 技术架构

### 开发框架
- **SwiftUI**：主要 UI 框架
- **Combine**：响应式编程（如需要）
- **Core Data**：数据持久化（预留）

### 架构模式
- **MVVM**：视图与业务逻辑分离
- **组件化设计**：可复用的 UI 组件
- **状态管理**：使用 `@State`、`@StateObject`、`@ObservedObject`

### 主要技术点
- **异步图片加载**：`AsyncImage` 加载网络图片
- **手势识别**：右滑删除功能
- **动画效果**：流畅的页面转场和交互动画
- **自定义导航**：底部悬浮导航栏

## 📁 项目结构

```
cook01/
├── cook01/
│   ├── Components/          # 可复用组件
│   │   ├── BottomBar.swift           # 底部导航栏
│   │   ├── RecipeCard.swift          # 菜谱卡片
│   │   ├── RecipeGridCard.swift      # 网格菜谱卡片
│   │   ├── StepCard.swift            # 步骤卡片
│   │   ├── IngredientGroup.swift     # 食材分组
│   │   └── ...
│   │
│   ├── Models/              # 数据模型
│   │   ├── Recipe.swift              # 菜谱模型
│   │   ├── Step.swift                # 步骤模型
│   │   ├── Ingredient.swift          # 食材模型
│   │   └── ...
│   │
│   ├── Views/               # 视图层
│   │   ├── Home/
│   │   │   ├── HomeView.swift        # 首页
│   │   │   └── LinkImportResultView.swift  # 链接导入结果
│   │   ├── Recipes/
│   │   │   └── RecipeDetailView.swift      # 菜谱详情
│   │   ├── Cooking/
│   │   │   ├── CookingModeView.swift       # 烹饪模式
│   │   │   └── CompletionCelebrationView.swift  # 完成庆祝
│   │   ├── Shopping/
│   │   │   └── ShoppingListView.swift      # 购物清单
│   │   └── Profile/
│   │       └── ProfileView.swift           # 个人中心
│   │
│   ├── ViewModels/          # 视图模型
│   │   ├── CookingProgress.swift          # 烹饪进度管理
│   │   ├── ShoppingListViewModel.swift    # 购物清单管理
│   │   └── AppState.swift                 # 应用状态
│   │
│   ├── Theme/               # 主题和样式
│   │   ├── Color+Theme.swift              # 颜色定义
│   │   ├── UIStyle.swift                  # UI 样式常量
│   │   ├── UIStyleGuide.md                # 样式使用指南
│   │   └── ButtonStyles.swift             # 按钮样式
│   │
│   ├── Utilities/           # 工具类
│   │   ├── Formatters.swift               # 格式化工具
│   │   └── ShoppingMerger.swift          # 购物清单合并逻辑
│   │
│   ├── MockData/            # 模拟数据
│   │   └── MockData.swift
│   │
│   └── CookAppApp.swift     # 应用入口
│
└── cook01.xcodeproj/        # Xcode 项目文件
```

## 🛠️ 开发环境要求

- **Xcode**: 15.0 或更高版本
- **iOS**: 17.0 或更高版本
- **Swift**: 5.9 或更高版本
- **macOS**: 14.0 或更高版本（用于开发）

## 🚀 安装和运行

### 1. 克隆项目
```bash
git clone <repository-url>
cd cook01
```

### 2. 打开项目
```bash
open cook01.xcodeproj
```

### 3. 运行项目
- 在 Xcode 中选择目标设备（模拟器或真机）
- 按 `Cmd + R` 运行项目
- 或使用 SwiftUI 预览功能查看单个视图

### 4. SwiftUI 预览
项目支持 SwiftUI 预览，可以在 Xcode 中直接预览各个视图：
- 打开任意 `.swift` 视图文件
- 点击右侧的 "Resume" 按钮启动预览
- 支持实时编辑和预览

## 📝 主要文件说明

### 核心视图

#### `CookingAppView.swift`
应用的主容器视图，管理页面导航和底部导航栏的显示逻辑。

#### `HomeView.swift`
首页视图，包含：
- 用户头像和问候语
- 链接导入卡片
- 菜谱历史网格布局
- 右滑删除功能

#### `RecipeDetailView.swift`
菜谱详情页，包含：
- 预览大图
- 基本信息展示
- Tab 切换（食材/步骤）
- 悬浮操作按钮

#### `CookingModeView.swift`
烹饪模式视图，包含：
- 步骤导航
- 计时器功能
- 进度条
- 控制按钮（播放/暂停、重置、下一步）

#### `LinkImportResultView.swift`
链接导入结果页，支持：
- 小红书链接解析
- 多菜谱识别
- 菜谱选择（高亮显示）
- 批量操作

### 核心组件

#### `BottomBar.swift`
底部导航栏组件，采用：
- 毛玻璃材质（`.ultraThinMaterial`）
- 胶囊形状（最大圆角）
- 悬浮设计
- 无文字标签，仅图标

#### `StepCard.swift`
步骤卡片组件，显示：
- 步骤序号（深红色圆形）
- 步骤描述
- 计时信息

#### `RecipeGridCard.swift`
网格菜谱卡片，用于首页展示：
- 圆形图片
- 菜谱名称
- 烹饪时间

### 样式系统

#### `UIStyle.swift`
全局 UI 样式常量系统，包含：
- 圆角半径 (`CornerRadius`)
- 间距 (`Spacing`)
- 内边距 (`Padding`)
- 字体大小 (`FontSize`)
- 按钮尺寸 (`Button`)
- 各页面专用样式 (`Home`, `RecipeDetail`, `Cooking`, 等)

**使用示例**：
```swift
// 使用样式常量
.padding(UIStyle.Padding.lg)
.cornerRadius(UIStyle.CornerRadius.large)
.font(.system(size: UIStyle.FontSize.body))
```

#### `Color+Theme.swift`
颜色主题定义，包含：
- 红色主题色系（替代绿色）
- 灰色系
- 设计专用颜色（`darkRed` 等）

## 🎯 样式调整指南

项目采用集中式样式管理，所有 UI 尺寸都可以在 `UIStyle.swift` 中调整：

### 快速调整示例

1. **调整头像尺寸**：
   ```swift
   // 在 UIStyle.swift 中
   struct Home {
       static let avatarSize: CGFloat = 80  // 修改此值
   }
   ```

2. **调整按钮高度**：
   ```swift
   struct Button {
       static let height: CGFloat = 56  // 修改此值
   }
   ```

3. **调整间距**：
   ```swift
   struct Spacing {
       static let lg: CGFloat = 16  // 修改此值
   }
   ```

详细指南请参考：`cook01/Theme/UIStyleGuide.md`

## 🔧 已知问题和注意事项

1. **Xcode 缓存问题**：如果修改 `UIStyle.swift` 后 UI 没有变化，请尝试：
   - 清理构建缓存：`Product > Clean Build Folder` (Shift + Cmd + K)
   - 重启 SwiftUI 预览
   - 完全重新编译项目

2. **图片加载**：应用使用 `AsyncImage` 加载网络图片，需要网络连接。

3. **数据持久化**：当前版本使用模拟数据，数据持久化功能（Core Data）已预留但未完全实现。

## 📦 依赖项

项目目前没有外部依赖，所有功能均使用 SwiftUI 原生实现。

## 🗂️ 存档信息

### 存档日期
2024年12月

### 项目状态
- ✅ UI 设计完成
- ✅ 核心功能实现
- ✅ 样式系统建立
- ⚠️ 数据持久化（部分实现）
- ⚠️ 网络请求（模拟数据）

### 主要完成内容

1. **UI 还原**
   - 100% 还原设计稿的 UI 样式
   - 实现所有页面的视觉设计
   - 统一的颜色主题和圆角系统

2. **功能实现**
   - 菜谱浏览和详情展示
   - 烹饪步骤导航和计时
   - 购物清单管理
   - 链接导入功能（UI 完成）

3. **代码优化**
   - 建立全局样式常量系统 (`UIStyle.swift`)
   - 组件化设计，提高代码复用性
   - 清晰的代码结构和注释

4. **样式系统**
   - 集中式 UI 样式管理
   - 便于精细化调整和全局修改
   - 完整的样式使用指南

### 技术亮点

- **现代化 UI**：采用 SwiftUI 最新特性，流畅的动画和交互
- **可维护性**：集中式样式管理，易于调整和维护
- **组件化**：高度可复用的组件设计
- **响应式设计**：适配不同屏幕尺寸

## 📄 许可证

本项目为存档项目，仅供学习和参考使用。

## 👤 作者

项目存档于 2024年12月

---

**注意**：本项目为存档版本，部分功能可能尚未完全实现。如需继续开发，请参考代码注释和 `UIStyleGuide.md` 进行扩展。

