import SwiftUI

/// 全局UI样式常量 - 统一管理所有UI尺寸、间距、字体等，方便精细化调整
struct UIStyle {
    
    // MARK: - 圆角半径
    struct CornerRadius {
        static let small: CGFloat = 8      // 小圆角：按钮、小卡片
        static let medium: CGFloat = 12   // 中等圆角：按钮、卡片
        static let large: CGFloat = 16    // 大圆角：卡片、容器（主要使用）
        static let extraLarge: CGFloat = 28 // 超大圆角：大卡片
        static let maximum: CGFloat = 50   // 最大圆角：导航栏胶囊形状
    }
    
    // MARK: - 间距
    struct Spacing {
        static let xs: CGFloat = 4    // 极小间距
        static let sm: CGFloat = 8   // 小间距
        static let md: CGFloat = 12  // 中等间距
        static let lg: CGFloat = 16   // 大间距
        static let xl: CGFloat = 20   // 超大间距
        static let xxl: CGFloat = 24 // 特大间距
        static let xxxl: CGFloat = 32 // 极大间距
    }
    
    // MARK: - 内边距
    struct Padding {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 24
        static let xxxl: CGFloat = 32
        static let bottomForNavigation: CGFloat = 100 // 导航栏底部预留空间
    }
    
    // MARK: - 字体大小
    struct FontSize {
        static let caption: CGFloat = 12
        static let footnote: CGFloat = 13
        static let subheadline: CGFloat = 15
        static let body: CGFloat = 17
        static let bodyLarge: CGFloat = 21  // 烹饪步骤文字（body + 4pt）
        static let callout: CGFloat = 16
        static let title3: CGFloat = 20
        static let title2: CGFloat = 22
        static let title1: CGFloat = 28
        static let largeTitle: CGFloat = 34
        static let timer: CGFloat = 72      // 计时器字体
    }
    
    // MARK: - 按钮尺寸
    struct Button {
        static let height: CGFloat = 56           // 控制按钮高度
        static let heightSmall: CGFloat = 36      // 小按钮高度（如静音按钮）
        static let heightMedium: CGFloat = 44    // 中等按钮高度
        static let iconSize: CGFloat = 22         // 导航栏图标大小
        static let iconSizeSmall: CGFloat = 16    // 小图标大小
        static let iconSizeLarge: CGFloat = 48    // 大图标大小（空状态）
    }
    
    // MARK: - 导航栏
    struct BottomBar {
        static let iconSize: CGFloat = 22
        static let activeCircleSize: CGFloat = 48
        static let horizontalPadding: CGFloat = 32
        static let verticalPadding: CGFloat = 16
        static let outerHorizontalPadding: CGFloat = 16
        static let bottomPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 50
    }
    
    // MARK: - 烹饪页面
    struct Cooking {
        static let recipeImageHeight: CGFloat = 240
        static let stepTextSize: CGFloat = 21     // 步骤文字大小（body + 4pt）
        static let stepTextWeight: Font.Weight = .bold
        static let timerSize: CGFloat = 72
        static let timerHeight: CGFloat = 100
        static let controlButtonSize: CGFloat = 56
        static let controlButtonSpacing: CGFloat = 32
        static let controlButtonCornerRadius: CGFloat = 12  // 播放按钮圆角
        static let voiceButtonSize: CGFloat = 36
        static let progressBarHeight: CGFloat = 2
        static let headerSpacing: CGFloat = 8
        static let contentSpacing: CGFloat = 24
    }
    
    // MARK: - 阴影
    struct Shadow {
        static let color: Color = .black
        static let opacity: Double = 0.08
        static let radius: CGFloat = 8
        static let y: CGFloat = -2
    }
    
    // MARK: - 动画
    struct Animation {
        static let duration: Double = 0.25
        static let springResponse: Double = 0.3
        static let springDamping: Double = 0.7
        static let timerPulseDuration: Double = 0.9
    }
    
    // MARK: - 边框
    struct Border {
        static let width: CGFloat = 1
        static let widthThick: CGFloat = 2
    }
    
    // MARK: - 图片尺寸
    struct Image {
        static let recipeCard: CGFloat = 100      // 首页食谱卡片图片
        static let recipeDetail: CGFloat = 260   // 详情页主图
        static let cookingStep: CGFloat = 240     // 烹饪步骤图片
        static let emptyStateIcon: CGFloat = 80   // 空状态图标
    }
    
    // MARK: - 行高/行间距
    struct Line {
        static let spacing: CGFloat = 6           // 步骤文字行间距
        static let spacingSmall: CGFloat = 4      // 小行间距
    }
    
    // MARK: - 首页 (Home)
    struct Home {
        // 头像
        static let avatarSize: CGFloat = 80
        static let avatarBorderWidth: CGFloat = 2
        static let avatarIconSize: CGFloat = 32
        static let avatarShadowRadius: CGFloat = 4
        static let avatarShadowY: CGFloat = 2
        
        // 问候文本
        static let greetingTitleSize: CGFloat = 16
        static let greetingSubtitleSize: CGFloat = 20
        static let greetingHeight: CGFloat = 56
        static let greetingSpacing: CGFloat = 16
        
        // 导入卡片
        static let importCardHeight: CGFloat = 70        // 粘贴链接框高度（总高度）
        static let importCardPaddingH: CGFloat = 16       // 水平内边距
        static let importCardPaddingV: CGFloat = 14       // 垂直内边距（如果使用 frame 高度，这个可以忽略）
        static let importCardCornerRadius: CGFloat = 50    // 圆角半径
        static let importCardIconSize: CGFloat = 16       // 图标大小
        static let importCardFontSize: CGFloat = 15       // 字体大小
        static let importCardSpacing: CGFloat = 12        // 图标和输入框间距
        
        // 食谱区域
        static let sectionTitleSize: CGFloat = 20
        static let sectionSubtitleSize: CGFloat = 14
        static let sectionTitleSpacing: CGFloat = 6
        static let sectionSpacing: CGFloat = 16
        static let gridSpacing: CGFloat = 12
        static let gridColumns: Int = 2
        
        // 空状态
        static let emptyStateHeight: CGFloat = 60
        static let emptyStateDashPattern: [CGFloat] = [8, 6]
    }
    
    // MARK: - 链接导入结果页 (LinkImportResult)
    struct LinkImport {
        // 头部预览卡片
        static let headerSpacing: CGFloat = 16
        static let headerImageSize: CGFloat = 96
        static let headerCardCornerRadius: CGFloat = 24
        static let headerCardPaddingH: CGFloat = 18
        static let headerCardPaddingV: CGFloat = 16
        
        // 识别提示文案
        static let summaryFontSize: CGFloat = 16
        
        // 菜谱网格
        static let gridSpacing: CGFloat = 20
        static let cardCornerRadius: CGFloat = 28
        static let cardPadding: CGFloat = 20
        static let cardImageSize: CGFloat = 140
        static let cardContentSpacing: CGFloat = 16
        
        // 选中高亮
        static let cardBorderWidth: CGFloat = 2
        static let checkBadgeSize: CGFloat = 28
        static let checkIconSize: CGFloat = 16
    }
    
    // MARK: - 首页食谱卡片 (RecipeGridCard)
    struct RecipeGridCard {
        static let imageSize: CGFloat = 100
        static let cardSpacing: CGFloat = 12
        static let nameFontSize: CGFloat = 14
        static let timeIconSize: CGFloat = 11
        static let timeFontSize: CGFloat = 12
        static let timeSpacing: CGFloat = 4
        static let paddingTop: CGFloat = 12
        static let paddingBottom: CGFloat = 16
        static let paddingHorizontal: CGFloat = 12
        static let backgroundOpacity: Double = 0.4
    }
    
    // MARK: - 购物清单页面 (Shopping)
    struct Shopping {
        static let cardPadding: CGFloat = 20
        static let cardSpacing: CGFloat = 16
        static let rowSpacing: CGFloat = 12
        static let rowPaddingV: CGFloat = 10
        static let rowPaddingH: CGFloat = 14
        static let checkboxSize: CGFloat = 28
        static let checkboxBorderWidth: CGFloat = 2
        static let checkboxIconSize: CGFloat = 14
        static let deleteButtonPadding: CGFloat = 6
        static let deleteButtonOpacity: Double = 0.1
        static let metadataPaddingH: CGFloat = 10
        static let metadataPaddingV: CGFloat = 6
    }
    
    // MARK: - 详情页 (RecipeDetail)
    struct RecipeDetail {
        static let heroImageHeight: CGFloat = 260
        static let heroPadding: CGFloat = 20
        static let heroSpacing: CGFloat = 12
        static let heroInfoSpacing: CGFloat = 12
        static let backButtonPadding: CGFloat = 10
        static let backButtonSize: CGFloat = 44
        static let tabSwitcherHeight: CGFloat = 44
        static let tabSpacing: CGFloat = 12
    }
    
    // MARK: - 个人资料页面 (Profile)
    struct Profile {
        static let avatarSize: CGFloat = 120
        static let avatarBadgeSize: CGFloat = 38
        static let avatarBadgeBorderWidth: CGFloat = 3
        static let avatarBadgeIconSize: CGFloat = 12
        static let avatarSpacing: CGFloat = 12
        static let statsGridColumns: Int = 3
        static let statsGridSpacing: CGFloat = 12
        static let statsIconSize: CGFloat = 18
        static let statsIconContainerSize: CGFloat = 44
        static let statsPadding: CGFloat = 14
        static let sectionSpacing: CGFloat = 24
        static let menuItemSpacing: CGFloat = 16
    }
    
    // MARK: - 按钮样式
    struct ButtonStyle {
        static let paddingVertical: CGFloat = 14
        static let paddingHorizontal: CGFloat = 18
        static let pressedOpacity: Double = 0.8
        static let pressedScale: CGFloat = 0.98
        static let animationDuration: Double = 0.15
    }
    
    // MARK: - 删除操作
    struct Delete {
        static let threshold: CGFloat = -80
        static let buttonSize: CGFloat = 60
        static let animationResponse: Double = 0.3
        static let animationDamping: Double = 0.7
        static let delay: Double = 0.3
    }
}



