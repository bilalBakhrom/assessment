//
//  MainDetails.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct MainDetails: Codable {
    public var temp, feelsLike, tempMin, tempMax: Double
    public var pressure, humidity: Int
    public var seaLevel, grndLevel: Int

    public init(
        temp: Double? = nil,
        feelsLike: Double? = nil,
        tempMin: Double? = nil,
        tempMax: Double? = nil,
        pressure: Int? = nil,
        humidity: Int? = nil,
        seaLevel: Int? = nil,
        grndLevel: Int? = nil
    ) {
        self.temp = temp ?? .notAvailable
        self.feelsLike = feelsLike ?? .notAvailable
        self.tempMin = tempMin ?? .notAvailable
        self.tempMax = tempMax ?? .notAvailable
        self.pressure = pressure ?? .notAvailable
        self.humidity = humidity ?? .notAvailable
        self.seaLevel = seaLevel ?? .notAvailable
        self.grndLevel = grndLevel ?? .notAvailable
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
