//
//  WindowSizeKey.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI

public struct WindowSizeEnvironmentKey: EnvironmentKey {
    static public var defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    public var windowSize: CGSize {
        get { self[WindowSizeEnvironmentKey.self] }
        set { self[WindowSizeEnvironmentKey.self] = newValue }
    }
}
