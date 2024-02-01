//
//  BaseCoordinator.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-07.
//

import UIKit
import AppModels

open class BaseCoordinator: Coordinator {
    public var navigationController: BaseNavigationController
    
    public init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    open func start(animated: Bool = true) {
        fatalError("Override this method")
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
}
