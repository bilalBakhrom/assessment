//
//  ANError.swift
//  
//
//  Created by Bilal Bakhrom on 2024-01-15.
//

import Foundation

public enum ANError: Error {
    case badStatusCode(statusCode: Int)
    case internalServerError(content: ANErrorContent)
}
