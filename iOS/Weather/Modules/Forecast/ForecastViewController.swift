//
//  ForecastViewController.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import AppBaseController

final class ForecastController: BaseViewController {
    // MARK: - Properties
    
    private let viewModel: ForecastViewModel
    
    private lazy var rootView: UIView = {
        let swiftUIView = ForecastView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return hostingController.view
    }()
    
    // MARK: - Initialization
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Layout
    
    override func embedSubviews() {
        view.addSubview(rootView)
    }
    
    override func activateSubviewsConstraints() {
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
