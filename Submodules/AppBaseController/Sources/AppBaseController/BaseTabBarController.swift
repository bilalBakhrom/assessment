//
//  BaseTabBarController.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-07.
//

import UIKit
import Combine
import AppModels

open class BaseTabBarController: NiblessTabBarController {
    /// Set of Combine cancellables for managing subscriptions.
    public var subscriptions = Set<AnyCancellable>()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
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
