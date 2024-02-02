//
//  Gradients++.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI

extension LinearGradient {
    public static var blueSkyGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.blue.opacity(0.5),
                Color.blue
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
