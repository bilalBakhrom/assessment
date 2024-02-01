//
//  TabBarViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController

public final class TabBarViewModel: BaseViewModel {
    private let coordinator: TabBarCoordinator
    
    public init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
    }
}
