//
//  AppIconType.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation

public enum AppIconType: Int, CaseIterable {
    case logo
    case gauge
    case tabMain
    case tabForecast
    case tabMainFilled
    case tabForecastFilled
}

extension AppIconType {
    public var assetName: String {
        switch self {
        case .logo:
            return "icon.logo"
        case .gauge:
            return "icon.gauge"
        case .tabMain:
            return "icon.tabbar.main"
        case .tabMainFilled:
            return "icon.tabbar.main.fill"
        case .tabForecast:
            return "icon.tabbar.forecast"
        case .tabForecastFilled:
            return "icon.tabbar.forecast.fill"
        }
    }
}
