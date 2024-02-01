//
//  GeocodingRouter.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import NetworkFoundation

public enum GeocodingRouter: ANBaseRouterProtocol {
    case fetchCities(model: RMGeocoding)

    public var host: String {
        return "https://api.openweathermap.org"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchCities:
            return .get
        }
    }

    public var path: String {
        switch self {
        case .fetchCities:
            return "/geo/1.0/direct"
        }
    }
    
    public var queryParameters: Parameters? {
        switch self {
        case .fetchCities(let model):
            return model.dictionary
        }
    }
}
