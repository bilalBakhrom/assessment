//
//  RMForecast.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public struct RMForecast: Codable {
    public let lat: Double
    public let lon: Double
    public let appid: String
    public let cnt: Int
    public let units: RMUnits
    
    public init(lat: Double, lon: Double, daysCount: Int, units: RMUnits = .metric, appID: String? = nil) {
        self.lat = lat
        self.lon = lon
        self.cnt = daysCount
        self.units = units
        self.appid = appID ?? NetworkSettings.shared.appID
    }
}
