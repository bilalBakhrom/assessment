//
//  MainViewContent.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI
import AppUIKit
import AppAssets
import AppColors
import AppModels
import AppSettings

struct MainViewContent: View {
    // MARK: - Properties
    
    @ObservedObject var viewModel: MainViewModel
    var details: WeatherDetails
    
    @EnvironmentObject private var locationManager: LocationManager
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.windowSize) private var windowSize
    
    private var gridItemWidth: CGFloat {
        return (windowSize.width - 56) / 2
    }
    
    private var columns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }
    
    // MARK: - Initialization
    
    init(viewModel: MainViewModel, details: WeatherDetails) {
        self.viewModel = viewModel
        self.details = details
    }
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: .zero) {
            contentHeaderView
                .padding(.top, 60 + safeAreaInsets.top)
                .padding(.bottom, 20)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    contentRecommendationView
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                        AUIFeelsLike(
                            value: details.vwFeelsLike,
                            recommendation: details.feelsLikeRecommendation
                        )
                        .frame(width: gridItemWidth, height: gridItemWidth)
                        
                        AUIVisibility(
                            value: details.vwVisibility,
                            recommendation: details.visibilityRecommendation
                        )
                        .frame(width: gridItemWidth, height: gridItemWidth)
                        
                        AUIHumidity(
                            value: details.vwHumidity,
                            recommendation: details.humidityRecommendation
                        )
                        .frame(width: gridItemWidth, height: gridItemWidth)
                        
                        AUIPressure(value: details.main.pressure)
                            .frame(width: gridItemWidth, height: gridItemWidth)
                    }
                    
                    VStack(spacing: 8) {
                        Button {
                            Task { await viewModel.sendEvent(.onTapChange)}
                        } label: {
                            Text("Change Location")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.modulePrimaryLabel)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                        }
                        .background(Color.moduleAccent)
                        .clipShape(.rect(cornerRadius: 12))
                        .opacity(0.8)
                        
                        if viewModel.hasSelectedCity {
                            Button {
                                Task { await viewModel.sendEvent(.removeSelectedCity) }
                            } label: {
                                Text("Remove")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.moduleMainRed)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100 + safeAreaInsets.bottom)
            }
        }
        .background(LinearGradient.blueSkyGradient)
    }
    
    private var contentHeaderView: some View {
        VStack(spacing: 8) {
            VStack(spacing: 4) {
                Text("My Location")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundStyle(Color.modulePrimaryLabel)
                
                Text(String(locationManager.placeMark?.country ?? details.name ?? "").uppercased())
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.modulePrimaryLabel)
            }
            
            Text(details.vwTemp)
                .font(.system(size: 100, weight: .medium))
                .foregroundStyle(Color.modulePrimaryLabel)
            
            VStack(spacing: 4) {
                Text(details.description)
                
                Text("H: \(details.vwTempMax)  L: \(details.vwTempMin)")
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Color.modulePrimaryLabel)
        }
    }
    
    private var contentRecommendationView: some View {
        HStack(spacing: 12) {
            if let url = details.iconURL, viewModel.networkMonitor.isReachable {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
            }
            
            if !viewModel.isFetchingWeatherDetails {
                Text(details.temperatureRecommendation)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.modulePrimaryLabel)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer(minLength: .zero)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .clipShape(.rect(cornerRadius: 12))
    }
}
