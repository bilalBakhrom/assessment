//
//  SafeAreaInsetsKey.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import UIKit

private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.mainWindow?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    public var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsEnvironmentKey.self]
    }
}

private extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
