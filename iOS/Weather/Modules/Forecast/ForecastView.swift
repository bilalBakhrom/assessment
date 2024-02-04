//
//  ForecastView.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import AppUIKit
import AppColors

struct ForecastView: View {
    @ObservedObject var viewModel: ForecastViewModel
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if viewModel.isFetchingForecast {
                ZStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let content = viewModel.content {
                ForecastViewContent(viewModel: viewModel, content: content)
            }
        }
        .ignoresSafeArea()
        .background(
            (viewModel.content?.isDaylight ?? viewModel.applicationSettings.isDaylight)
            ? LinearGradient.daylightGradient
            : LinearGradient.nightGradient
        )
    }
}
