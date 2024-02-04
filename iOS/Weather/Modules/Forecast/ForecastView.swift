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
            } else {
                content
            }
        }
        .ignoresSafeArea()
        .background(
            (viewModel.content?.isDaylight ?? viewModel.applicationSettings.isDaylight)
            ? LinearGradient.daylightGradient
            : LinearGradient.nightGradient
        )
    }
    
    private var content: some View {
        ZStack {
            if let content = viewModel.content {
                AUIList {
                    Section {
                        ForEach(content.list) { forecast in
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
        }
        .padding(.top, safeAreaInsets.top)
    }
}
