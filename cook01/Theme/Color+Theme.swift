import SwiftUI

extension Color {
    // 红色主题色系（替代绿色）
    static let orange50   = Color(hex: 0xFEF2F2)  // 浅红背景
    static let orange100  = Color(hex: 0xFEE2E2)  // 浅红
    static let orange200  = Color(hex: 0xFECACA)  // 浅红边框
    static let orange300  = Color(hex: 0xFCA5A5)  // 浅红强调
    static let orange400  = Color(hex: 0xF87171)  // 中等红
    static let orange500  = Color(hex: 0x7C0013)  // 主红色（与darkRed一致）
    static let orange600  = Color(hex: 0xDC2626)  // 深红
    static let orange700  = Color(hex: 0xB91C1C)  // 更深红
    static let orange800  = Color(hex: 0x991B1B)  // 深红
    static let orange900  = Color(hex: 0x7F1D1D)  // 最深红

    // 琥珀色系改为浅红色系
    static let amber50    = Color(hex: 0xFEF2F2)  // 浅红背景
    static let amber100   = Color(hex: 0xFEE2E2)  // 浅红
    static let amber200   = Color(hex: 0xFECACA)  // 浅红边框
    static let amber400   = Color(hex: 0xF87171)  // 中等红
    static let amber500   = Color(hex: 0x7C0013)  // 主红色（与darkRed一致）
    static let amber700   = Color(hex: 0xDC2626)  // 深红

    static let yellow50   = Color(hex: 0xFEFCE8)

    static let red50      = Color(hex: 0xFEF2F2)
    static let red400     = Color(hex: 0xF87171)
    static let red500     = Color(hex: 0xEF4444)

    static let gray200    = Color(hex: 0xE5E7EB)
    static let gray300    = Color(hex: 0xD1D5DB)
    static let gray400    = Color(hex: 0x9CA3AF)
    static let gray500    = Color(hex: 0x6B7280)
    static let gray600    = Color(hex: 0x4B5563)
    static let gray700    = Color(hex: 0x374151)
    static let gray800    = Color(hex: 0x1F2937)

    static let green400   = Color(hex: 0x7C0013)  // 改为红色主题色
    static let emerald500 = Color(hex: 0x7C0013)  // 改为红色主题色
    
    // 设计稿专用颜色
    static let darkRed    = Color(hex: 0x7C0013)  // 高亮红色，用于主按钮、进度条、选中状态
    static let darkGreen  = Color(hex: 0x7C0013)  // 改为红色主题色（用于计时器）
    
    // UI背景色
    static let searchBackground = Color(hex: 0xF8F8F8)  // 搜索框背景色
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

