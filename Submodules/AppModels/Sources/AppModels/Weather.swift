//
//  Weather.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import Foundation
import AppNetwork

public struct Weather: Codable {
    public var id: Int
    public var main: String
    public var icon: String
    public var description: WeatherDescription
    
    public init(
        id: Int?,
        main: String?,
        description: WeatherDescription?,
        icon: String?
    ) {
        self.id = id ?? 0
        self.main = main ?? ""
        self.description = description ?? .clearSky
        self.icon = icon ?? ""
    }
    
    public init(from response: ANWeather?) {
        self.init(
            id: response?.id,
            main: response?.main,
            description: WeatherDescription(rawValue: response?.description ?? ""),
            icon: response?.icon
        )
    }
}
