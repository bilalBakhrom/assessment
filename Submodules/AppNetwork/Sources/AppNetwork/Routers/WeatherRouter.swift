//
//  WeatherRouter.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import NetworkFoundation

public enum WeatherRouter: ANBaseRouterProtocol {
    case fetchWeatherDetails(model: RMLocation)

    public var host: String {
        return "https://api.openweathermap.org"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchWeatherDetails:
            return .get
        }
    }

    public var path: String {
        switch self {
        case .fetchWeatherDetails:
            return "/data/2.5/weather"
        }
    }
    
    public var queryParameters: Parameters? {
        switch self {
        case .fetchWeatherDetails(let model):
            return model.dictionary
        }
    }
}
