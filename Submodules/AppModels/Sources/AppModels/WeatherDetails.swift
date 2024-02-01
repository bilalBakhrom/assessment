//
//  WeatherDetails.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppNetwork

// MARK: - Weather Data
public struct WeatherDetails: Codable {
    public var id: Int
    public var coord: AppCoordinates
    public var weather: [Weather]?
    public var main: Main?
    public var timezone: Int?
    public var name: String?
    
    public var description: String {
        weather?.first?.description.description ?? ""
    }
    
    public var temp: Int {
        Int(main?.temp ?? 0)
    }
    
    public var tempMax: Int {
        Int(main?.tempMax ?? 0)
    }
    
    public var tempMin: Int {
        Int(main?.tempMin ?? 0)
    }
    
    public var recommendation: String {
        switch temp {
        case ..<0:
            return "Bundle up, it's freezing outside!"
        case 0...15:
            return "It's quite chilly, wear a jacket."
        case 15...:
            return "Lovely weather for a day out!"
        default:
            return ""
        }
    }
    
    public init(
        id: Int?,
        coord: AppCoordinates,
        weather: [Weather]?,
        main: Main?,
        timezone: Int?,
        name: String?
    ) {
        self.id = id ?? 0
        self.coord = coord
        self.weather = weather
        self.main = main
        self.timezone = timezone
        self.name = name
    }
}

extension WeatherDetails {
    public init(from response: ANWeatherDetails?) {
        self.init(
            id: response?.id,
            coord: AppCoordinates(
                lat: response?.coord?.lat ?? 0,
                lon: response?.coord?.lon ?? 0
            ),
            weather: response?.weather?.map({ Weather(from: $0) }),
            main: Main(from: response?.main),
            timezone: response?.timezone,
            name: response?.name
        )
    }
}

// MARK: - Weather
public struct Weather: Codable {
    public var id: Int
    public var main: String
    public var icon: String
    public var description: WeatherDescription
    
    public init(
        id: Int?,
        main: String?,
        description: WeatherDescription?,
        icon: String?
    ) {
        self.id = id ?? 0
        self.main = main ?? ""
        self.description = description ?? .clearSky
        self.icon = icon ?? ""
    }
    
    public init(from response: ANWeather?) {
        self.init(
            id: response?.id,
            main: response?.main,
            description: WeatherDescription(rawValue: response?.description ?? ""),
            icon: response?.icon
        )
    }
}

// MARK: - Main
public struct Main: Codable {
    public var temp, feelsLike, tempMin, tempMax: Double?
    public var pressure, humidity: Int?
    public var seaLevel, grndLevel: Int?
    
    public init(
        temp: Double?,
        feelsLike: Double?,
        tempMin: Double?,
        tempMax: Double?,
        pressure: Int?,
        humidity: Int?,
        seaLevel: Int?,
        grndLevel: Int?
    ) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }
    
    public init(from response: ANMain?) {
        self.init(
            temp: response?.temp,
            feelsLike: response?.feelsLike,
            tempMin: response?.tempMin,
            tempMax: response?.tempMax,
            pressure: response?.pressure,
            humidity: response?.humidity,
            seaLevel: response?.seaLevel,
            grndLevel: response?.grndLevel
        )
    }
}

