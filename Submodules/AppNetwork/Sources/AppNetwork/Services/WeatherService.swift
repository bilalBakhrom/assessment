//
//  WeatherService.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import NetworkFoundation

public protocol WeatherServiceProtocol {
    func fetchWeatherDetails(with model: RMLocation) async throws -> ANWeatherDetails
    func fetchForecast(model: RMForecast) async throws -> ANForecastContent
}

final public class WeatherService: ANBaseRouterService<WeatherRouter>, WeatherServiceProtocol {
    public func fetchWeatherDetails(with model: RMLocation) async throws -> ANWeatherDetails {
        try await performRequest(ANWeatherDetails.self, from: .fetchWeatherDetails(model: model))
    }
    
    public func fetchForecast(model: RMForecast) async throws -> ANForecastContent {
        try await performRequest(ANForecastContent.self, from: .fetchForecast(model: model))
    }
}

