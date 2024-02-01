//
//  MainCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController

public struct MainDependency {
    
}

public final class MainCoordinator: BaseCoordinator {
    public let dependency: MainDependency
    
    public init(_ dependency: MainDependency, navigationController: BaseNavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
