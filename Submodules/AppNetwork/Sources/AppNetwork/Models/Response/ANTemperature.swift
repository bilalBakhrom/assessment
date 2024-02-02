//
//  ANTemperature.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation

public struct ANTemperature: Codable {
    public let day: Double?
    public let min: Double?
    public let max: Double?
    public let night: Double?
    public let eve: Double?
    public let morn: Double?
}
