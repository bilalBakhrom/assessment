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
    public var main: MainDetails
    public var timezone: Int?
    public var name: String?
    
    public var description: String {
        weather?.first?.description.description ?? ""
    }
    
    public var vwTemp: String {
        let value = Int(main.temp)
        return value == .notAvailable ? "-" : "\(value)°"
    }
     
    public var vwTempMax: String {
        let value = Int(main.tempMax)
        return value == .notAvailable ? "-" : "\(value)°"
    }
    
    public var vwTempMin: String {
        let value = Int(main.tempMin)
        return value == .notAvailable ? "-" : "\(value)°"
    }
    
    public var iconURL: URL? {
        guard let icon = weather?.first?.icon else { return nil }            
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
    
    public var recommendation: String {
        switch main.temp {
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
        main: MainDetails?,
        timezone: Int?,
        name: String?
    ) {
        self.id = id ?? 0
        self.coord = coord
        self.weather = weather
        self.main = main ?? MainDetails()
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
            main: MainDetails(from: response?.main),
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

