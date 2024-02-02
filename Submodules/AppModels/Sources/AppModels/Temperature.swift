//
//  Temperature.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct Temperature: Codable {
    public let day: Double
    public let min: Double
    public let max: Double
    public let night: Double
    public let eve: Double
    public let morn: Double
    
    public init(
        day: Double? = nil,
        min: Double? = nil,
        max: Double? = nil,
        night: Double? = nil,
        eve: Double? = nil,
        morn: Double? = nil
    ) {
        self.day = day ?? 0
        self.min = min ?? 0
        self.max = max ?? 0
        self.night = night ?? 0
        self.eve = eve ?? 0
        self.morn = morn ?? 0
    }
    
    public init(from response: ANTemperature?) {
        self.init(
            day: response?.day,
            min: response?.min,
            max: response?.max,
            night: response?.night,
            eve: response?.eve,
            morn: response?.morn
        )
    }
}
