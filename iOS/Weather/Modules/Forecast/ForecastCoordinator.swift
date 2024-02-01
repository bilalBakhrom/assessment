//
//  ForecastCoordinator.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController

public struct ForecastDependency {
    
}

public final class ForecastCoordinator: BaseCoordinator {
    public let dependency: ForecastDependency
    
    public init(_ dependency: ForecastDependency, navigationController: BaseNavigationController) {
        self.dependency = dependency
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewModel = ForecastViewModel(coordinator: self)
        let viewController = ForecastController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
