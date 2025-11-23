import SwiftUI

extension Color {
    // 绿色主题色系（替代橙色）
    static let orange50   = Color(hex: 0xF0FDF4)  // 浅绿背景
    static let orange100  = Color(hex: 0xDCFCE7)  // 浅绿
    static let orange200  = Color(hex: 0xBBF7D0)  // 浅绿边框
    static let orange300  = Color(hex: 0x86EFAC)  // 浅绿强调
    static let orange400  = Color(hex: 0x4ADE80)  // 中等绿
    static let orange500  = Color(hex: 0x22C55E)  // 主绿色
    static let orange600  = Color(hex: 0x16A34A)  // 深绿
    static let orange700  = Color(hex: 0x15803D)  // 更深绿
    static let orange800  = Color(hex: 0x166534)  // 深绿
    static let orange900  = Color(hex: 0x14532D)  // 最深绿

    // 琥珀色系改为浅绿色系
    static let amber50    = Color(hex: 0xF0FDF4)  // 浅绿背景
    static let amber100   = Color(hex: 0xDCFCE7)  // 浅绿
    static let amber200   = Color(hex: 0xBBF7D0)  // 浅绿边框
    static let amber400   = Color(hex: 0x4ADE80)  // 中等绿
    static let amber500   = Color(hex: 0x22C55E)  // 主绿色
    static let amber700   = Color(hex: 0x16A34A)  // 深绿

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

    static let green400   = Color(hex: 0x34D399)
    static let emerald500 = Color(hex: 0x10B981)
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

