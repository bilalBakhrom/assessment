//
//  FontRegister.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-14.
//

import UIKit

/// Protocol for providing font name and extension information.
public protocol FontInfo {
    var fontName: String { get }
    var fontExtension: String { get }
}

/// A utility for managing and registering custom fonts.
public struct FontRegister {
    public init() {}
    
    /// Registers fonts specified by the provided enum.
    ///
    /// - Parameters:
    ///   - fontEnum: An enum conforming to `CaseIterable` and `FontInfo` protocols.
    ///   - bundle: The bundle containing the font files.
    ///
    /// - Important: If the registration fails for any font, a fatal error will be triggered.
    public func registerFonts<T: CaseIterable & FontInfo>(from fontEnum: T.Type, with bundle: Bundle) {
        for fontInfo in T.allCases {
            registerFont(from: bundle, named: fontInfo.fontName, withExtension: fontInfo.fontExtension)
        }
    }
    
    /// Registers a custom font from the specified bundle.
    ///
    /// - Parameters:
    ///   - bundle: The bundle containing the font file.
    ///   - fontName: The name of the font file (without extension).
    ///   - fontExtension: The file extension of the font file.
    ///
    /// - Important: If the registration fails, a fatal error will be triggered.
    public func registerFont(from bundle: Bundle, named fontName: String, withExtension fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider)
        else {
            fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        
        if let registrationError = error?.takeRetainedValue() {
            fatalError("Failed to register font: \(registrationError)")
        }
    }
}
