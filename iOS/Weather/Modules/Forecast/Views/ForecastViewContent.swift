//
//  ForecastViewContent.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-05.
//

import SwiftUI
import AppUIKit
import AppColors
import AppAssets
import AppModels

struct ForecastViewContent: View {
    @ObservedObject var viewModel: ForecastViewModel
    var content: DailyForecasts
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(viewModel: ForecastViewModel, content: DailyForecasts) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    AUIHourlyForecast(forecasts: content.next48HoursForecasts)
                    
                    AUIForecastTable(forecasts: content.averageForecasts)
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, safeAreaInsets.top)
    }
}
