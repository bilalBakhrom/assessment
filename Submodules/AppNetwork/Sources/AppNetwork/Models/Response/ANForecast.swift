//
//  ANForecast.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public struct ANForecast: Codable {
    public let dt: Int?
    public let sunrise: Int?
    public let sunset: Int?
    public let temp: ANTemperature?
    public let feelsLike: ANFeelsLike?
    public let pressure: Int?
    public let humidity: Int?
    public let weather: [ANWeather]?
    public let speed: Double?
    public let deg: Int?
    public let gust: Double?
    public let clouds: Int?
    public let pop: Double?
    public let rain: Double?
}

// MARK: - CODING KEYS

extension ANForecast {
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
        case feelsLike = "feels_like"
    }
}
