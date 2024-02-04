//
//  DailyForecasts.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct DailyForecasts: Codable {
    public let city: City
    public let numberOfDays: Int
    public let list: [Forecast]
    public var forecastsByDate: [String: [Forecast]]
    
    public var isDaylight: Bool {
        guard let sunsetTimestamp = city.sunsetTimestamp, let sunriseTimestamp = city.sunriseTimestamp else {
            return true
        }
        
        let currentTime = Date().timeIntervalSince1970
        return currentTime >= TimeInterval(sunriseTimestamp) && currentTime <= TimeInterval(sunsetTimestamp)
    }
    
    // Returns the next 24 hours' forecasts
    public var next48HoursForecasts: [Forecast] {
        let now = Date().timeIntervalSince1970
        let endOfNext24Hours = now + 24 * 60 * 60 * 2// 24 hours in seconds
        
        return list
            .filter { $0.timestamp >= Int(now) && $0.timestamp <= Int(endOfNext24Hours) }
            .sorted { $0.timestamp < $1.timestamp }
    }
    
    public var averageForecasts: [Forecast] {
        forecastsByDate
            .compactMap { $0.value[safe: 1] ?? $0.value.first }
            .sorted { $0.timestamp < $1.timestamp }
    }
    
    public init(
        city: City?,
        numberOfDays: Int?,
        list: [Forecast]?
    ) {
        self.city = city ?? City()
        self.numberOfDays = numberOfDays ?? 0
        self.list = list ?? []
        self.forecastsByDate = Dictionary(grouping: list ?? []) { $0.dateByDay }
    }
    
    public init(from response: ANDailyForecasts) {
        self.init(
            city: City(from: response.city),
            numberOfDays: response.cnt,
            list: response.list?.map({ Forecast(from: $0) })
        )
    }
}
