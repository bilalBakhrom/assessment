//
//  WeatherDescription.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public enum WeatherDescription: String, Codable, CustomStringConvertible {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain
    case thunderstorm
    case snow
    case mist
    
    public var description: String {
         switch self {
         case .clearSky:
             return "Clear Sky"
         case .fewClouds:
             return "Light Clouds"
         case .scatteredClouds:
             return "Partly Cloudy"
         case .brokenClouds:
             return "Mostly Cloudy"
         case .showerRain:
             return "Rain Showers"
         case .rain:
             return "Rainy"
         case .thunderstorm:
             return "Stormy"
         case .snow:
             return "Snowy"
         case .mist:
             return "Misty"
         }
     }
}
