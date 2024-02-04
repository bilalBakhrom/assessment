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
            AUIList {
                Section {
                    ForEach(content.averageForecasts) { forecast in
                        HStack {
                            Text(forecast.formattedDate)
                            
                            Spacer()
                            
                            Text("H: \(forecast.tempMax)°  L: \(forecast.tempMin)°")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.modulePrimaryLabel)
                        .id(forecast.id)
                    }
                } header: {
                    Text("5-day forecast".uppercased())
                        .font(.system(size: 12))
                        .foregroundStyle(Color.modulePrimaryLabel)
                }
            }
            .listStyle(.grouped)
        }
        .padding(.top, safeAreaInsets.top)
    }
}
