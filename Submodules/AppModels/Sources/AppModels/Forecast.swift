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
    public let temperature: Temperature
    
    public var description: String {
        weather.first?.description.description ?? ""
    }
    
    public var temp: Int {
        Int(temperature.day)
    }
    
    public var tempMax: Int {
        Int(temperature.max)
    }
    
    public var tempMin: Int {
        Int(temperature.min)
    }
    
    public var formattedDate: String {
        // Create a Date instance from the timestamp
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        // Check if the date is today
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else {
            // Initialize a DateFormatter for the weekday
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            // Convert the Date to a String with the weekday name
            return dateFormatter.string(from: date)
        }
    }
    
    public init(
        timestamp: Int?,
        weather: [Weather]?,
        temperature: Temperature?
    ) {
        self.id = UUID().uuidString
        self.timestamp = timestamp ?? 0
        self.weather = weather ?? []
        self.temperature = temperature ?? Temperature()
    }
    
    public init(from response: ANForecast) {
        self.init(
            timestamp: response.dt,
            weather: response.weather?.map({ Weather(from: $0) }),
            temperature: Temperature(from: response.temp)
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
