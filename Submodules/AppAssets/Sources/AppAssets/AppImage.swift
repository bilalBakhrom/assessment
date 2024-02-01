//
//  AppImage.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI

public struct AppImage: View {
    public var type: AppImageType
    
    public init(_ type: AppImageType) {
        self.type = type
    }
    
    public var body: Image {
        Image(type.assetName, bundle: .module)
            .resizable()
    }
}
