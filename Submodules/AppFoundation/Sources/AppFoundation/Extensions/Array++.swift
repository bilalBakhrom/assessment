//
//  Array++.swift
//  
//
//  Created by Bilal Bakhrom on 2023-06-13.
//

import Foundation

extension Array where Element: Encodable {
    public subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
