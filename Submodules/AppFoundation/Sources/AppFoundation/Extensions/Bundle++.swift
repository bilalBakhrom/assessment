//
//  Bundle++.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-20.
//

import Foundation

extension Bundle {
    public var appVersion: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    public var appBuildNumber: String {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
}
