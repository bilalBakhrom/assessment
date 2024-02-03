//
//  ScrollOffsetPreferenceKey.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGPoint = .zero
    
    public static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
