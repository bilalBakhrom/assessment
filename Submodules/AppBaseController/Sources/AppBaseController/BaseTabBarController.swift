//
//  BaseTabBarController.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-07.
//

import UIKit
import Combine
import AppModels
import AppColors

open class BaseTabBarController: NiblessTabBarController {
    /// Set of Combine cancellables for managing subscriptions.
    public var subscriptions = Set<AnyCancellable>()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .moduleTabBarBackground // Set your custom color
        appearance.selectionIndicatorTintColor = .moduleAccent
        
        // Set both the standardAppearance and scrollEdgeAppearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // Update tint color.
        tabBar.tintColor = .moduleAccent
    }
    
    // MARK: - BINDER
    
    open func bind() {}
    
    /// Performs initial requests asynchronously.
    open func performInitialRequests() async {}
    
    // MARK: - Layout
    
    /// Sets up subviews by embedding and activating constraints.
    open func setupSubviews() {
        embedSubviews()
        activateSubviewsConstraints()
    }
    
    /// Embeds subviews into the view.
    open func embedSubviews() {}
    
    /// Activates constraints for subviews.
    open func activateSubviewsConstraints() {}
}
