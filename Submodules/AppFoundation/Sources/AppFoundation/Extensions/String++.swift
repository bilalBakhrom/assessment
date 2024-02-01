//
//  String++.swift
//  
//
//  Created by Bilal Bakhrom on 2024-01-20.
//

import Foundation

extension String {
    public var uppercasedFirstLetter: String {
        var letters = self.map { String($0) }
        letters[0] = letters[0].uppercased()
        
        return letters.joined(separator: "")
    }
    
    public var uppercasedLeadingLetters: String {
        let words = self.split(separator: " ").map(String.init)
        let newWords = words.map { $0.uppercasedFirstLetter }
        
        return newWords.joined(separator: " ")
    }
}
