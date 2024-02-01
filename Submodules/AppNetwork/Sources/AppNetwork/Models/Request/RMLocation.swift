//
//  RMLocation.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation

public struct RMLocation: Codable {
    public let lat: Double
    public let lon: Double
    public let appID: String
    public let units: Units
    
    public init(lat: Double, lon: Double, appID: String, units: Units = .metric) {
        self.lat = lat
        self.lon = lon
        self.appID = appID
        self.units = units
    }
}

extension RMLocation {
    public enum Units: String, Codable {
        case standard
        case metric
        case imperial
    }
}

// MARK: - CODING KEYS

extension RMLocation {
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case appID = "appid"
        case units
    }
}
