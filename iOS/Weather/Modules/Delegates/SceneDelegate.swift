//
//  SceneDelegate.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppSettings
import AppNetwork

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootCoordinator: RootCoordinator?
    var networkMonitor = NetworkReachabilityMonitor()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let applicationSettings = ApplicationSettings.shared
        let locationManager = LocationManager()
        networkMonitor.start()
        
        let dependency = RootCoordinatorDependency(
            applicationSettings: applicationSettings,
            locationManager: locationManager,
            networkMonitor: networkMonitor
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

