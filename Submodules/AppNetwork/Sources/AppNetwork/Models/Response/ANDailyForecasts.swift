//
//  ANDailyForecasts.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

// Define the top-level structure
public struct ANDailyForecasts: Codable {
    public let city: City?
    public let cod: String?
    public let message: Double?
    public let cnt: Int?
    public let list: [ANForecast]?
}

extension ANDailyForecasts {
    public struct City: Codable {
        public let id: Int?
        public let name: String?
        public let coord: ANCoord?
        public let country: String?
        public let population: Int?
        public let timezone: Int?
        public var sunset: Int?
        public var sunrise: Int?
    }
}
