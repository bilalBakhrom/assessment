//
//  Color++.swift
//
//
//  Created by Bilal Bakhrom on 2023-06-13.
//

import SwiftUI

extension UIColor {
    public static func blend(color1: UIColor, intensity1: CGFloat = 1, color2: UIColor, intensity2: CGFloat = 0.5) -> UIColor {
        let total = intensity1 + intensity2
        let l1 = intensity1 / total
        let l2 = intensity2 / total
        guard l1 > 0 else { return color2}
        guard l2 > 0 else { return color1}
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
    }
    
    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    public static func blend(color1: Color, intensity1: CGFloat = 1, color2: Color, intensity2: CGFloat = 0.5) -> Color {
        let blendColor = UIColor.blend(
            color1: UIColor(color1),
            intensity1: intensity1,
            color2: UIColor(color2),
            intensity2: intensity2
        )
        return Color(uiColor: blendColor)
    }
    
    public init(hex: String) {
        self.init(uiColor: UIColor(hex: hex))
    }
}
