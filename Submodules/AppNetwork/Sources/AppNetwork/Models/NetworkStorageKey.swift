//
//  NetworkStorageKey.swift
//  
//
//  Created by Bilal Bakhrom on 2024-01-14.
//

import Foundation
import AppFoundation

public enum NetworkStorageKey: String, StorageKeyProtocol {
    case token = "@storage.network.token"
    
    public var key: String { rawValue }
}
