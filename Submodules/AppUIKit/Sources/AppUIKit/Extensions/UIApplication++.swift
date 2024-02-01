//
//  UIApplication++.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import UIKit

extension UIApplication {
    public var mainWindow: UIWindow? {
        if let lastWindow = connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last {
            return lastWindow
        } else {
            // Get connected scenes
            return self.connectedScenes
                // Keep only active scenes, onscreen and visible to the user
                .filter { $0.activationState == .foregroundActive }
                // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
                // Get its associated windows
                .flatMap { $0 as? UIWindowScene }?.windows
                // Finally, keep only the key window
                .first(where: \.isKeyWindow)
        }
    }
}

