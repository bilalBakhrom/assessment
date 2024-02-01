//
//  BaseViewController.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-07.
//

import SwiftUI
import Combine
import AppColors
import AppSettings
import AppNetwork
import AppModels

/// A base view controller class with common functionalities.
open class BaseViewController: NiblessViewController {
    // MARK: - Properties
    
    // MARK: Private Stored Properties
    
    /// Determines whether the font should be adjusted for content size categories.
    public var adjustsFontForContentSizeCategory: Bool = false
    
    /// Set of Combine cancellables for managing subscriptions.
    public var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    /// Initializes a `BaseViewController` instance.
    public init() {
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        updateNavigationBarBackground(to: .clear)
    }
    
    // MARK: - Appearance
    
    private func setupAppearance() {
        // Set background color based on user interface style.
        view.backgroundColor = .modulePrimaryBackground
    }
    
    // MARK: - BINDERS
    
    open func bind() {}
    
    // MARK: - Network
    
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

// MARK: - NAVIGATION BAR CONTROL

extension BaseViewController {
    /// Updates the navigation bar background color.
    public func updateNavigationBarBackground(to color: UIColor?) {
        let appearance = UINavigationBarAppearance()
        
        // Configure appearance based on the provided color.
        color == .clear
        ? appearance.configureWithTransparentBackground()
        : appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = color
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        // Apply appearance to different navigation bar states.
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
    }
    
    /// Updates the navigation bar back button with a specified type.
    public func updateNavigationBarBackButton(to backButtonType: NavigationBackButtonType = .darkSquare) {
        let image = UIImage(named: backButtonType.name)
        let backButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        backButton.setImage(image, for: .normal)
        backButton.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    /// Sets the navigation bar title with the given string.
    public func setNavigationBar(title: String?) {
        // Create new label.
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.sizeToFit()
        label.text = title
        label.alpha = 0
        
        // Wrap the label changes in an animation block.
        UIView.animate(withDuration: 0.15) {
            // Set the alpha to 1 for a smooth fade-in effect.
            label.alpha = 1
        }
        
        // Set the navigation item's title view.
        navigationItem.titleView = title == nil ? nil : label
    }
    
    /// Shows the navigation bar.
    public func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /// Hides the navigation bar.
    public func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc
    private func handleBackButtonClick() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - NAVIGATION STACK CONTROL

extension BaseViewController {
    /// Removes the previous screen from the navigation stack.
    public func removePreviousScreen() {
        guard let navigationController = navigationController, navigationController.viewControllers.count >= 2 else { return }
        
        let index = navigationController.viewControllers.count - 2
        navigationController.viewControllers.remove(at: index)
    }
    
    /// Removes the previous screen of a specific type from the navigation stack.
    public func removePreviousScreen<T: UIViewController>(ofType type: T.Type) {
        guard let navigationController = navigationController, navigationController.viewControllers.count >= 2,
              let index = navigationController.viewControllers.firstIndex(where: { $0.isKind(of: type) }) else { return }
        
        navigationController.viewControllers.remove(at: index)
    }
}

extension BaseViewController {
    public func showError(with content: ANErrorContent?) {
        guard let content else { return }
        
        let alertController = UIAlertController(
            title: content.errorTitle,
            message: content.errortDescription,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alertController, animated: true)
    }
}
