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
    
    public init(query: String, appid: String, limit: Int = 10) {
        self.query = query
        self.appid = appid
        self.limit = limit
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
