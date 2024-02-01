//
//  AppImageType.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation

public enum AppImageType: Int, CaseIterable {
    case test
    
    public var assetName: String {
        switch self {
        case .test:
            return "img.test"
        }
    }
}
