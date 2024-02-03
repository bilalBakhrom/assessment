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
    public var timezone: Int?
    public var name: String?
    public var visibility: Int
    public var main: MainAnalytics
    public var wind: WindAnalytics
    public var sunriseTimestamp: Int
    public var sunsetTimestamp: Int
    
    public var description: String {
        weather?.first?.description.description ?? ""
    }
    
    public var isDaylight: Bool {
        let currentTime = Date().timeIntervalSince1970
        return currentTime >= TimeInterval(sunriseTimestamp) && currentTime <= TimeInterval(sunsetTimestamp)
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
    
    public var vwFeelsLike: String {
        let value = Int(main.feelsLike)
        return value == .notAvailable ? "-" : "\(value)°"
    }
    
    public var vwVisibility: String {
        let value = visibility
        return value == .notAvailable ? "-" : "\(value / 1000) km"
    }
    
    public var vwHumidity: String {
        let value = main.humidity
        return value == .notAvailable ? "-" : "\(value)%"
    }
    
    public var vwPressure: String {
        let value = main.pressure
        return value == .notAvailable ? "-" : "\(value) hPa"
    }
    
    // MARK: - Recommendations
    
    public var temperatureRecommendation: String {
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
    
    public var feelsLikeRecommendation: String {
        guard main.feelsLike != .notAvailable else {
            return ""
        }
        
        let feelsLikeTemperature = Int(main.feelsLike)
        var message: String = ""
        
        if feelsLikeTemperature < 0 {
            message = " Dress warmly in layers."
        } else if feelsLikeTemperature < 10 {
            message = "Wear a coat and consider a hat and gloves."
        } else if feelsLikeTemperature < 20 {
            message = "A light jacket or sweater is recommended."
        } else if feelsLikeTemperature < 30 {
            message = "Ideal for outdoor activities."
        } else if feelsLikeTemperature < 35 {
            message = "Stay hydrated and wear sunscreen."
        } else {
            message = "Limit outdoor activities and seek shade."
        }
        
        return message
    }
    
    public var visibilityRecommendation: String {
        guard visibility != .notAvailable else {
            return ""
        }
        
        var message: String = ""
        
        if visibility < 1000 {
            message = "Be cautious outdoors."
        } else if visibility < 3000 {
            message = "Exercise caution."
        } else if visibility < 5000 {
            message = "Stay alert."
        } else if visibility < 8000 {
            message = "Proceed normally."
        } else {
            message = "Enjoy outdoors."
        }
        
        return message
    }
    
    public var humidityRecommendation: String {
        guard main.humidity != .notAvailable else {
            return ""
        }
        
        var message: String = ""
        
        if main.humidity < 30 {
            message = "Air is dry. Stay hydrated."
        } else if main.humidity < 60 {
            message = "Comfortable humidity."
        } else if main.humidity < 80 {
            message = "Feels humid. Stay cool."
        } else {
            message = "Very humid. Avoid exertion."
        }
        
        return message
    }
    
    public var iconURL: URL? {
        guard let icon = weather?.first?.icon else { return nil }            
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
    
    // MARK: - Initialization
    
    public init(
        id: Int?,
        coord: AppCoordinates,
        weather: [Weather]?,
        timezone: Int?,
        name: String?,
        visibility: Int?,
        sunriseTimestamp: Int?,
        sunsetTimestamp: Int?,
        main: MainAnalytics?,
        wind: WindAnalytics?
    ) {
        self.id = id ?? 0
        self.coord = coord
        self.weather = weather
        self.main = main ?? MainAnalytics()
        self.timezone = timezone
        self.name = name
        self.visibility = visibility ?? .notAvailable
        self.sunriseTimestamp = sunriseTimestamp ?? .notAvailable
        self.sunsetTimestamp = sunsetTimestamp ?? .notAvailable
        self.wind = wind ?? WindAnalytics()
    }

    public init(from response: ANWeatherDetails?) {
        self.init(
            id: response?.id,
            coord: AppCoordinates(
                lat: response?.coord?.lat ?? 0,
                lon: response?.coord?.lon ?? 0
            ),
            weather: response?.weather?.map({ Weather(from: $0) }),
            timezone: response?.timezone,
            name: response?.name,
            visibility: response?.visibility,
            sunriseTimestamp: response?.sys?.sunrise,
            sunsetTimestamp: response?.sys?.sunset,
            main: MainAnalytics(from: response?.main),
            wind: WindAnalytics(from: response?.wind)
        )
    }
}
