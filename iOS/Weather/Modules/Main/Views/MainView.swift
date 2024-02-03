//
//  MainView.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import AppUIKit
import AppColors
import AppSettings

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject private var locationManager: LocationManager
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if locationManager.isNotAuthorized {
                AUILocationAccessNeeded {
                    await viewModel.sendEvent(.openSettings)
                }
            } else {
                if let details = viewModel.details {
                    MainViewContent(viewModel: viewModel, details: details)
                } else {
                    MainViewPlaceholder(isFetchingDetails: $viewModel.isFetchingWeatherDetails)
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $viewModel.isLocationPickerPresented) {
            MainLocationPickerView(viewModel: viewModel)
                .background(Color.modulePrimaryBackground)
        }
    }
}
