//
//  WindAnalytics.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import Foundation
import AppNetwork

public struct WindAnalytics: Codable, Identifiable {
    public let id: String
    
    /// Wind speed (meter/sec).
    public let speed: Double
    
    /// Wind direction, degress.
    public let degree: Double
    
    /// Wind gust (meter/sec).
    public let gust: Double
    
    public init(
        speed: Double? = nil,
        deg: Double? = nil,
        gust: Double? = nil
    ) {
        self.id = UUID().uuidString
        self.speed = speed ?? .notAvailable
        self.degree = deg ?? .notAvailable
        self.gust = gust ?? .notAvailable
    }
    
    public init(from response: ANWind?) {
        self.init(
            speed: response?.speed,
            deg: response?.deg,
            gust: response?.gust
        )
    }
}

extension WindAnalytics: Hashable {}
