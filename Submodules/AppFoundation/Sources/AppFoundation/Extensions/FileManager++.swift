//
//  FileManager++.swift
//
//
//  Created by Bilal Bakhrom on 19/06/2022.
//

import Foundation

public extension FileManager {
    static var documentURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
