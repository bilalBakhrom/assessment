//
//  NetworkReachabilityMonitor.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import Foundation
import Network
import Combine

/// A delegate protocol for receiving network reachability updates.
public protocol NetworkReachabilityMonitorDelegate: AnyObject {
    /// Called when the network reachability status is updated.
    ///
    /// - Parameters:
    ///   - monitor: The `NetworkReachabilityMonitor` instance.
    ///   - isReachable: A boolean indicating whether the network is reachable.
    func networkReachabilityMonitorDidUpdateStatus(_ monitor: NetworkReachabilityMonitor, isReachable: Bool)
}

/// A class responsible for monitoring network reachability and notifying observers of status changes.
final public class NetworkReachabilityMonitor {
    private let networkStatusSubject = PassthroughSubject<Bool, Never>()
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")
    
    /// A weak reference to the delegate that will receive network reachability updates.
    public weak var delegate: NetworkReachabilityMonitorDelegate?
    
    /// A publisher that emits a boolean value indicating whether the network is reachable.
    public var statusPublisher: AnyPublisher<Bool, Never> {
        networkStatusSubject.eraseToAnyPublisher()
    }

    /// Initializes a new `NetworkReachabilityMonitor` instance.
    public init() {
        configureNetworkPathMonitor()
    }
    
    /// Starts monitoring network reachability.
    public func start() {
        monitor.start(queue: monitorQueue)
    }
    
    /// Stops monitoring network reachability.
    public func stop() {
        monitor.cancel()
    }
    
    // MARK: - CONFIGURATION
    
    private func configureNetworkPathMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            let isReachable = path.status == .satisfied
            self.networkStatusSubject.send(isReachable)
            self.delegate?.networkReachabilityMonitorDidUpdateStatus(self, isReachable: isReachable)
        }
    }
}
