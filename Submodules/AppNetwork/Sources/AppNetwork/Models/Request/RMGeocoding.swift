//
//  RMGeocoding.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public struct RMGeocoding: Codable {
    public var query: String
    public var appid: String
    public var limit: Int
    
    public init(query: String, limit: Int = 10, appID: String? = nil) {
        self.query = query
        self.limit = limit
        self.appid = appID ?? NetworkSettings.shared.appID
    }
}

// MARK: - CODING KEYS

extension RMGeocoding {
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case appid
        case limit
    }
}
