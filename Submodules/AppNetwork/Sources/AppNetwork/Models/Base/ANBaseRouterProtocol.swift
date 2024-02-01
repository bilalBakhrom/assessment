//
//  ANBaseRouterProtocol.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-19.
//

import Foundation
import NetworkFoundation

public protocol ANBaseRouterProtocol: RouterProtocol {}

extension ANBaseRouterProtocol {
    public var host: String {
        return ""
    }
    
    public var headers: HTTPHeaders {
        return HTTPHeaders()
    }
}
