//
//  AppIcon.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI

public struct AppIcon: View {
    public var type: AppIconType
    
    public init(_ type: AppIconType) {
        self.type = type
    }
    
    public var body: Image {
        Image(type.assetName, bundle: .module)
            .resizable()
    }
}
