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
