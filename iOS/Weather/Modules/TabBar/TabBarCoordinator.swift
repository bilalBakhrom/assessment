//
//  TabBarCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController
import AppSettings

public struct TabBarDependency {
    public let applicationSettings: ApplicationSettings
    
    public init(applicationSettings: ApplicationSettings) {
        self.applicationSettings = applicationSettings
    }
}

public final class TabBarCoordinator: BaseCoordinator {
    public let dependency: TabBarDependency
    
    public init(_ dependency: TabBarDependency, navigationController: BaseNavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewModel = TabBarViewModel(coordinator: self)
        let viewController = TabBarController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
