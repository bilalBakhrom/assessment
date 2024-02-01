//
//  City.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import AppNetwork

public struct City: Codable {
    public var name: String
    public var lat: Double
    public var lon: Double
    public var country: String
    
    public init(
        name: String?,
        lat: Double?,
        lon: Double?,
        country: String?
    ) {
        self.name = name ?? ""
        self.lat = lat ?? 0
        self.lon = lon ?? 0
        self.country = country ?? ""
    }
    
    public init(from response: ANCity?) {
        self.init(
            name: response?.name,
            lat: response?.lat,
            lon: response?.lon,
            country: response?.country
        )
    }
}

