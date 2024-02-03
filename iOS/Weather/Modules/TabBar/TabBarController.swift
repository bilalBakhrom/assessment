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
            locationManager: viewModel.locationManager,
            networkMonitor: viewModel.networkMonitor
        )
        let navController = BaseNavigationController()
        navController.tabBarItem = .createTabBarItem(for: .main)
        
        let coordinator = MainCoordinator(dependency, navigationController: navController)
        coordinator.start()
        
        return navController
    }()
    
    private lazy var middleViewController: UIViewController = {
        let viewController = UIViewController()
        
        return viewController
    }()
    
    private lazy var forecastViewController: UIViewController = {
        let dependency = ForecastDependency(
            applicationSettings: viewModel.applicationSettings,
            locationManager: viewModel.locationManager,
            networkMonitor: viewModel.networkMonitor
        )
        let navController = BaseNavigationController()
        navController.tabBarItem = .createTabBarItem(for: .forecast)
        
        let coordinator = ForecastCoordinator(dependency, navigationController: navController)
        coordinator.start()
        
        return navController
    }()
    
    private lazy var middleButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "plus")
        configuration.background.cornerRadius = 32
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .moduleAccent
        
        let view = UIButton(configuration: configuration)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 64, height: 64))
        view.addTarget(self, action: #selector(handleMiddleButtonClick), for: .touchUpInside)
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        
        return view
    }()
    
    // MARK: - Initialization
    
    public init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setViewControllers([mainViewController, middleViewController, forecastViewController], animated: false)
        view.addSubview(middleButton)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMiddleButton()
    }
    
    private func setupMiddleButton() {
        middleButton.frame.origin = CGPoint(
            x: view.bounds.width / 2 - middleButton.frame.size.width / 2,
            y: view.bounds.height - middleButton.frame.height - view.safeAreaInsets.bottom
        )
        middleButton.configuration?.background.cornerRadius = middleButton.frame.height / 2
        middleButton.layer.cornerRadius = middleButton.frame.height / 2
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
    
    // MARK: - Actions
    
    @objc
    private func handleMiddleButtonClick() {
        let alertController = UIAlertController(
            title: "Middle Button Alert",
            message: "In process..",
            preferredStyle: .alert
        )
        
        alertController.addAction(.init(title: "Ok", style: .cancel))
        
        present(alertController, animated: true)
    }
}
