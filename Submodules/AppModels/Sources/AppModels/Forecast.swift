//
//  Forecast.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct Forecast: Codable, Identifiable {
    public let id: String
    public let timestamp: Int
    public let weather: [Weather]
    public let main: MainAnalytics
    
    public var description: String {
        weather.first?.description.description ?? ""
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
    
    public var date: Date {
        Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    public var dateByDay: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
         
        if let year = components.year,
           let month = components.month,
           let day = components.day {
            
            return "\(year).\(month).\(day)"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
            return dateFormatter.string(from: date)
        }
    }
    
    public var formattedDate: String {
        // Initialize a DateFormatter for the weekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = .autoupdatingCurrent
        
        // Define a tolerance in seconds
        let tolerance: TimeInterval = 6400
        
        let isNow = abs(date.timeIntervalSinceNow) <= tolerance
        
        if isNow {
            return "Now"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    
    public var formattedDateByWeekName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.timeZone = .autoupdatingCurrent
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    
    public init(
        timestamp: Int?,
        weather: [Weather]?,
        main: MainAnalytics?
    ) {
        self.id = UUID().uuidString
        self.timestamp = timestamp ?? 0
        self.weather = weather ?? []
        self.main = main ?? MainAnalytics()
    }
    
    public init(from response: ANForecast) {
        self.init(
            timestamp: response.dt,
            weather: response.weather?.map({ Weather(from: $0) }),
            main: MainAnalytics(from: response.main)
        )
    }
}

extension Forecast: Hashable {
    public static func == (lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
