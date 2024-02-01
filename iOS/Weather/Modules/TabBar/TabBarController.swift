//
//  TabBarController.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppBaseController

final class TabBarController: BaseTabBarController {
    // MARK: - Properties
    
    private let viewModel: TabBarViewModel
    
    private lazy var mainViewController: UIViewController = {
        let dependency = MainDependency()
        let navController = BaseNavigationController()
        
        let coordinator = MainCoordinator(dependency, navigationController: navController)
        coordinator.start()
        
        return navController
    }()
    
    private lazy var forecastViewController: UIViewController = {
        let dependency = ForecastDependency()
        let navController = BaseNavigationController()
        
        let coordinator = ForecastCoordinator(dependency, navigationController: navController)
        coordinator.start()
        
        return navController
    }()
    
    // MARK: - Initialization
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([mainViewController, forecastViewController], animated: false)
    }
}
