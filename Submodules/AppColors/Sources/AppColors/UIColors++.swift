//
//  UIColors++.swift
//  
//
//  Created by Bilal Bakhrom on 2024-01-20.
//

import UIKit

extension UIColor {
    public static var moduleAccent: UIColor {
        return fetchColor("ModuleAccentColor")
    }
    
    public static var moduleSecondaryAccent: UIColor {
        return fetchColor("ModuleSecondaryAccentColor")
    }
    
    public static var modulePrimaryBackground: UIColor {
        fetchColor("ModulePrimaryBackgroundColor")
    }
    
    public static var moduleSecondaryBackground: UIColor {
        fetchColor("ModuleSecondaryBackgroundColor")
    }
    
    public static var moduleTertiaryBackground: UIColor {
        fetchColor("ModuleTertiaryBackgroundColor")
    }
    
    public static var modulePrimaryLabel: UIColor {
        fetchColor("ModulePrimaryLabel")
    }
    
    public static var moduleSecondaryLabel: UIColor {
        fetchColor("ModuleSecondaryLabel")
    }
    
    public static var moduleMainRed: UIColor {
        fetchColor("ModuleRedColor")
    }
    
    public static var moduleMainBlue: UIColor {
        fetchColor("ModuleBlueColor")
    }
    
    public static var moduleCardinal: UIColor {
        fetchColor("ModuleCardinalColor")
    }
    
    public static var moduleDarkGradient: UIColor {
        fetchColor("ModuleDarkGradient")
    }
    
    public static var moduleSecondaryRed: UIColor {
        fetchColor("ModuleSecondaryRed")
    }
    
    public static var moduleDarkGradient2: UIColor {
        fetchColor("ModuleDarkGradient2")
    }
    
    public static var moduleGreen: UIColor {
        fetchColor("ModuleColorGreen")
    }
    
    public static var moduleGreenMindaro: UIColor {
        fetchColor("ModuleGreenMindaro")
    }
    
    public static var moduleGray: UIColor {
        UIColor.systemGray2
    }
    
    public static var moduleStrokeColor: UIColor {
        fetchColor("ModuleDefaultStrokeColor")
    }
    
    public static var moduleTabBarBackground: UIColor {
        fetchColor("ModuleTabBarBackground")
    }
}

extension UIColor {
    private static func fetchColor(_ name: String) -> UIColor {
        guard let color = UIColor(named: name, in: .module, compatibleWith: nil) else {
            fatalError()
        }
        
        return color
    }
}

