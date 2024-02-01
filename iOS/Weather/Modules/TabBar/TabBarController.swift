//
//  TabBarController.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import UIKit
import AppBaseController
import CoreLocation

public final class TabBarController: BaseTabBarController {
    // MARK: - Properties
    
    private let viewModel: TabBarViewModel
    
    private lazy var mainViewController: UIViewController = {
        let dependency = MainDependency(
            applicationSettings: viewModel.applicationSettings,
            locationManager: viewModel.locationManager
        )
        let navController = BaseNavigationController()
        navController.tabBarItem = .createTabBarItem(for: .main)
        
        let coordinator = MainCoordinator(dependency, navigationController: navController)
        coordinator.start()
        
        return navController
    }()
    
    private lazy var forecastViewController: UIViewController = {
        let dependency = ForecastDependency()
        let navController = BaseNavigationController()
        navController.tabBarItem = .createTabBarItem(for: .forecast)
        
        let coordinator = ForecastCoordinator(dependency, navigationController: navController)
        coordinator.start()
        
        return navController
    }()
    
    // MARK: - Initialization
    
    public init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setViewControllers([mainViewController, forecastViewController], animated: false)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - BINDER
    
    public override func bind() {
        viewModel.locationManager.$locationStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self else { return }
                handleLocationStatus(status)
            }
            .store(in: &subscriptions)
    }
    
    private func handleLocationStatus(_ status: CLAuthorizationStatus) {
        tabBar.isHidden = (status == .denied) || (status == .restricted)
    }
}
