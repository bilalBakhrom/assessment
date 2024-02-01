//
//  ApplicationStorageKey.swift
//  
//
//  Created by Bilal Bakhrom on 2024-01-14.
//

import Foundation
import AppFoundation

public enum ApplicationStorageKey: String, StorageKeyProtocol {
    case isFirstLaunch = "@storage.is_first_launch"
    case userInterfaceStyle = "@storage.user_interface_style"
    
    public var key: String { rawValue }
}

