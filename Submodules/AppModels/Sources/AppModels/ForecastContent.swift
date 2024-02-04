//
//  ForecastContent.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct ForecastContent: Codable {
    public let city: City
    public let numberOfDays: Int
    public let list: [Forecast]
    
    public var isDaylight: Bool {
        guard let sunsetTimestamp = city.sunsetTimestamp, let sunriseTimestamp = city.sunriseTimestamp else {
            return true
        }
        
        let currentTime = Date().timeIntervalSince1970
        return currentTime >= TimeInterval(sunriseTimestamp) && currentTime <= TimeInterval(sunsetTimestamp)
    }
    
    public init(
        city: City?,
        numberOfDays: Int?,
        list: [Forecast]?
    ) {
        self.city = city ?? City()
        self.numberOfDays = numberOfDays ?? 0
        self.list = list ?? []
    }
    
    public init(from response: ANForecastContent) {
        self.init(
            city: City(from: response.city),
            numberOfDays: response.cnt,
            list: response.list?.map({ Forecast(from: $0) })
        )
    }
}
