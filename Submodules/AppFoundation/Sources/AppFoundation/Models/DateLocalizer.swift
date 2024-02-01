//
//  DateLocalizer.swift
//  
//
//  Created by Bilal Bakhrom on 2023-06-12.
//

import Foundation

public struct DateLocalizer {
    public private(set) var locale: Locale = .current
    
    public init(locale: Locale = .current) {
        self.locale = locale
    }
    
    public mutating func updateLocale(identifier: String) {
        locale = Locale(identifier: identifier)
    }
    
    public func localizeMinutesToShortStyle(minutes: TimeInterval) -> String {
        let measurement = Measurement(value: minutes, unit: UnitDuration.minutes)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.locale = locale
        
        return formatter.string(from: measurement)
    }
    
    public func localizeMinutes(minutes: TimeInterval) -> String {
        let measurement = Measurement(value: minutes, unit: UnitDuration.minutes)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.locale = locale
        
        return formatter.string(from: measurement)
    }
}
