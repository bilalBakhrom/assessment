//
//  Colors++.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-20.
//

import SwiftUI

extension Color {
    public static var moduleAccent: Color {
        return Color("ModuleAccentColor", bundle: .module)
    }
    
    public static var moduleSecondaryAccent: Color {
        return Color("ModuleSecondaryAccentColor", bundle: .module)
    }
    
    public static var modulePrimaryBackground: Color {
        Color("ModulePrimaryBackgroundColor", bundle: .module)
    }
    
    public static var moduleSecondaryBackground: Color {
        Color("ModuleSecondaryBackgroundColor", bundle: .module)
    }
    
    public static var moduleTertiaryBackground: Color {
        Color("ModuleTertiaryBackgroundColor", bundle: .module)
    }
    
    public static var modulePrimaryLabel: Color {
        Color("ModulePrimaryLabel", bundle: .module)
    }
    
    public static var moduleSecondaryLabel: Color {
        Color("ModuleSecondaryLabel", bundle: .module)
    }
    
    public static var moduleMainRed: Color {
        Color("ModuleRedColor", bundle: .module)
    }
    
    public static var moduleMainBlue: Color {
        Color("ModuleBlueColor", bundle: .module)
    }
    
    public static var moduleCardinal: Color {
        Color("ModuleCardinalColor", bundle: .module)
    }
    
    public static var moduleDarkGradient: Color {
        Color("ModuleDarkGradient", bundle: .module)
    }
    
    public static var moduleSecondaryRed: Color {
        Color("ModuleSecondaryRed", bundle: .module)
    }
    
    public static var moduleDarkGradient2: Color {
        Color("ModuleDarkGradient2", bundle: .module)
    }
    
    public static var moduleGreen: Color {
        Color("ModuleColorGreen", bundle: .module)
    }
    
    public static var moduleGreenMindaro: Color {
        Color("ModuleGreenMindaro", bundle: .module)
    }
    
    public static var moduleGray: Color {
        Color(UIColor.systemGray2)
    }
    
    public static var moduleStrokeColor: Color {
        Color("ModuleDefaultStrokeColor", bundle: .module)
    }
    
    public static var moduleTabBarBackground: Color {
        Color("ModuleTabBarBackground", bundle: .module)
    }
}
