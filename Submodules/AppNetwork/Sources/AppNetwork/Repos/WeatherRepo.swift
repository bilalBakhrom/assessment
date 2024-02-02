//
//  WeatherRepo.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation

public protocol WeatherRepoProtocol {
    func fetchWeatherDetails(with model: RMLocation) async throws -> ANWeatherDetails
    func fetchForecast(model: RMForecast) async throws -> ANForecastContent
}

public final class WeatherRepo: WeatherRepoProtocol {
    private let _service: WeatherServiceProtocol
    
    public init(_service: WeatherServiceProtocol = WeatherService()) {
        self._service = _service
    }
    
    public func fetchWeatherDetails(with model: RMLocation) async throws -> ANWeatherDetails {
        try await _service.fetchWeatherDetails(with: model)
    }
    
    public func fetchForecast(model: RMForecast) async throws -> ANForecastContent {
        try await _service.fetchForecast(model: model)
    }
}
