//
//  ApplicationSettings.swift
//  WeatherFit
//
//  Created by Bilal Bakhrom on 28/01/2023.
//

import UIKit
import AppFoundation
import AppModels
import AppAssets

public final class ApplicationSettings {
    public static let shared = ApplicationSettings()
    private let storage: StorageKeyDefaults<ApplicationStorageKey>
    
    private init() {
        storage = StorageKeyDefaults(suiteName: "group.com.deeptechuz.kegelfit")
        storage.register(defaults: [
            .isFirstLaunch: true,
            .userInterfaceStyle: UIUserInterfaceStyle.dark.rawValue,
        ])
    }
}

public extension ApplicationSettings {
    var isFirstLaunch: Bool {
        get { storage.bool(forKey: .isFirstLaunch) }
        set { storage.set(newValue, forKey: .isFirstLaunch) }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        get { UIUserInterfaceStyle(rawValue: storage.integer(forKey: .userInterfaceStyle))! }
        set { storage.set(newValue.rawValue, forKey: .userInterfaceStyle) }
    }
    
    var userSelectedCity: City? {
        get {
            guard let data = storage.data(forKey: .userSelectedCity) else {
                return nil
            }
            
            return try? JSONDecoder().decode(City.self, from: data)
        }
        set {
            guard let city = newValue,
                  let data = try? JSONEncoder().encode(city)
            else { return }
            
            storage.set(data, forKey: .userSelectedCity)
        }
    }
}
