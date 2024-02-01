//
//  AppCoordinates.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation

public struct AppCoordinates: Codable, Hashable {
    public var lat: Double
    public var lon: Double
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
