//
//  LocationPickerViewController.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-04.
//

import SwiftUI
import AppBaseController

final class LocationPickerViewController: BaseViewController {
    // MARK: - Properties
    
    private let viewModel: LocationPickerViewModel
    
    private lazy var rootView: UIView = {
        let swiftUIView = LocationPickerView(viewModel: viewModel)
            .environment(\.windowSize, view.bounds.size)
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return hostingController.view
    }()
    
    // MARK: - Initialization
    
    init(viewModel: LocationPickerViewModel) {
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
    
    override func bind() {
        viewModel.$query
            .sink { [weak self] query in
                guard let self else { return }
                Task { await self.viewModel.sendEvent(.fetchCities(query: query)) }
            }
            .store(in: &subscriptions)
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
