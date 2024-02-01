//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import Foundation
import AppBaseController

final class ForecastViewModel: BaseViewModel {
    private let coordinator: ForecastCoordinator
    
    init(coordinator: ForecastCoordinator) {
        self.coordinator = coordinator
    }
}
