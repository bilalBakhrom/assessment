//
//  MainViewController.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import AppBaseController

final class MainController: BaseViewController {
    // MARK: - Properties
    
    private let viewModel: MainViewModel
    
    private lazy var rootView: UIView = {
        let swiftUIView = MainView(viewModel: viewModel)
            .environmentObject(viewModel.locationManager)
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return hostingController.view
    }()
    
    // MARK: - Initialization
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupSubviews()
        Task { await performInitialRequests() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    // MARK: - BINDER
    
    override func bind() {
        viewModel.locationManager
            .$location
            .sink { [weak self] location in
                guard let self else { return }
                
                Task {
                    await self.viewModel.sendEvent(.fetchWeatherDetails(location: location))
                }
            }
            .store(in: &subscriptions)
        
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                self?.showError(with: content)
            }
            .store(in: &subscriptions)
        
        viewModel.networkMonitor
            .statusPublisher
            .sink { [weak self] isReachable in
                guard let self, isReachable else { return }
                
                let location = viewModel.locationManager.location
                
                Task {
                    await self.viewModel.sendEvent(.fetchWeatherDetails(location: location))
                }
            }
            .store(in: &subscriptions)
    }
    
    override func performInitialRequests() async {
        if viewModel.locationManager.isAuthorized {
            await viewModel.sendEvent(.startUpdatingLocation)
        } else {
            await viewModel.sendEvent(.requestLocationAuthorization)
        }
    }
    
    // MARK: - Layout
    
    override func embedSubviews() {
        view.addSubview(rootView)
    }
    
    override func activateSubviewsConstraints() {
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
