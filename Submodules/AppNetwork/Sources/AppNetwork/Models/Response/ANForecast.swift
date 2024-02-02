//
//  ANForecast.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public struct ANForecast: Codable {
    public let dt: Int?
    public let main: ANMain?
    public let weather: [ANWeather]?
}

// MARK: - CODING KEYS

extension ANForecast {
    enum CodingKeys: String, CodingKey {
        case dt, main, weather
    }
}
