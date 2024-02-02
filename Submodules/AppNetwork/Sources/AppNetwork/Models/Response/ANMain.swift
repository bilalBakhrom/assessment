//
//  ANMain.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public struct ANMain: Codable {
    public var temp, feelsLike, tempMin, tempMax: Double?
    public var pressure, humidity: Int?
    public var seaLevel, grndLevel: Int?
}

// MARK: - CODING KEYS

extension ANMain {
    enum CodingKeys: String, CodingKey {
        case temp, feelsLike = "feels_like", tempMin = "temp_min", tempMax = "temp_max", 
             pressure, humidity, seaLevel = "sea_level", grndLevel = "grnd_level"
    }
}
