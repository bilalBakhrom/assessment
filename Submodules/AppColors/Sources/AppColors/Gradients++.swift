//
//  Gradients++.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI

extension LinearGradient {
    public static var daylightGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.blue.opacity(0.5),
                Color.blue
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    public static var nightGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.black.opacity(0.7),
                Color.purple.opacity(0.8),
                Color.blue.opacity(0.5)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
