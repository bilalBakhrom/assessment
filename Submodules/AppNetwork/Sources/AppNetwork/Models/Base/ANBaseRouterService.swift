//
//  ANBaseRouterService.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-19.
//

import Foundation
import NetworkFoundation

open class ANBaseRouterService<R: RouterProtocol>: RouterService<R> {
    @discardableResult
    public func performRequest<T, E>(_ type: T.Type, errorType: E.Type = ANErrorContent.self, from router: R) async throws -> T where T : Decodable, E : Decodable {
        do {
            return try await request(type, errorType: errorType, from: router)
        } catch NFError.decodedError(let anyModel) {
            if let content = anyModel as? ANErrorContent {
                throw ANError.internalServerError(content: content)
            } else {
                throw ANError.internalServerError(content: ANErrorContent())
            }
        } catch {
            throw error
        }
    }
}
