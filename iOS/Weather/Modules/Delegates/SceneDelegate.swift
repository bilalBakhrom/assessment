//
//  SceneDelegate.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppSettings

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootCoordinator: RootCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let applicationSettings = ApplicationSettings.shared
        let locationManager = LocationManager()
        
        let dependency = RootCoordinatorDependency(
            applicationSettings: applicationSettings,
            locationManager: locationManager
        )
        
        rootCoordinator = RootCoordinator(
            window: window,
            dependency: dependency
        )
        
        rootCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

