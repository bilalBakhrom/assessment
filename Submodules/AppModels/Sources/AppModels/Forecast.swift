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
    
    public var temp: Int {
        Int(main.temp)
    }
    
    public var tempMax: Int {
        Int(main.tempMax)
    }
    
    public var tempMin: Int {
        Int(main.tempMin)
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
        dateFormatter.dateFormat = "EEE +HH"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        // Convert the Date to a String with the weekday name
        return dateFormatter.string(from: date)
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
