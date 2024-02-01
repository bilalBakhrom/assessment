//
//  NavigationBackButtonType.swift
//  
//
//  Created by Bilal Bakhrom on 2024-01-07.
//

import UIKit

public enum NavigationBackButtonType: String {
    /// A dark square-shaped back button.
    case darkSquare
    
    /// Retrieves the corresponding image name for the back button type.
    var name: String {
        switch self {
        case .darkSquare:
            return "icon.navigation.back"
        }
    }
}
