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
    
    private let contentHeaderCompactHeight: CGFloat = 100
    private let contentHeaderHeight: CGFloat = 230
    private let contentHeaderVPadding: CGFloat = 40
    
    private var widgetWidth: CGFloat {
        return (windowSize.width - 56) / 2
    }
    
    private var columns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }
    
    private var contentHeaderCurrentVPadding: CGFloat {
        let offsetY = viewModel.scrollOffset.y
        
        if offsetY > 0 {
            return contentHeaderVPadding + offsetY
        }
        
        let result = contentHeaderVPadding - abs(offsetY)
        
        return result <= 0 ? 0 : result
    }
    
    private var opacityScrollOffsetY: CGFloat {
        guard viewModel.scrollOffset.y < 0 else { return 1 }
        
        let offsetY = viewModel.scrollOffset.y
        let result = offsetY + (contentHeaderVPadding * 2) - 20
        let modifiedValue = result < 0 ? abs(result) : 1
        
        return modifiedValue
    }
    
    // MARK: - Initialization
    
    init(viewModel: MainViewModel, details: WeatherDetails) {
        self.viewModel = viewModel
        self.details = details
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            AUIScrollView(scrollPosition: $viewModel.scrollOffset) {
                VStack(spacing: 20) {
                    contentRecommendationView
                    
                    AUIWind(
                        speed: details.wind.speed,
                        gust: details.wind.gust,
                        degree: details.wind.degree
                    )
                    .frame(height: widgetWidth)
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                        AUIFeelsLike(
                            value: details.vwFeelsLike,
                            recommendation: details.feelsLikeRecommendation
                        )
                        .frame(width: widgetWidth, height: widgetWidth)
                        
                        AUIVisibility(
                            value: details.vwVisibility,
                            recommendation: details.visibilityRecommendation
                        )
                        .frame(width: widgetWidth, height: widgetWidth)
                        
                        AUIHumidity(
                            value: details.vwHumidity,
                            recommendation: details.humidityRecommendation
                        )
                        .frame(width: widgetWidth, height: widgetWidth)
                        
                        AUIPressure(value: details.main.pressure)
                            .frame(width: widgetWidth, height: widgetWidth)
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
                .padding(.bottom, safeAreaInsets.bottom * 10)
                .padding(.top, (contentHeaderVPadding * 2) + contentHeaderHeight - contentHeaderCompactHeight)
            } // :AUIScrollView
            .padding(.top, contentHeaderCompactHeight + safeAreaInsets.top)
            
            VStack {
                contentHeaderView
                    .padding(.vertical, contentHeaderCurrentVPadding)
                
                Spacer()
            }
            .padding(.top, safeAreaInsets.top)
        }
        .background(details.isDaylight ? LinearGradient.daylightGradient : .nightGradient)
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
            
            if opacityScrollOffsetY < 68 {
                Text(details.vwTemp)
                    .font(.system(size: 100, weight: .medium))
                    .foregroundStyle(Color.modulePrimaryLabel)
                    .opacity(abs(1 - 70 / Double(opacityScrollOffsetY)))
            } else {
                Text("\(details.vwTemp) | \(details.description)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.modulePrimaryLabel)
                    .transition(.opacity)
            }
            
            VStack(spacing: 4) {
                if opacityScrollOffsetY <= 22 {
                    Text(details.description)
                        .transition(.opacity)
                }
                
                if opacityScrollOffsetY <= 10 {
                    Text("H: \(details.vwTempMax)  L: \(details.vwTempMin)")
                        .transition(.opacity)
                }
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Color.modulePrimaryLabel)
        }
        .animation(.linear(duration: 0.15), value: opacityScrollOffsetY)
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
            
            if !viewModel.isFetchingWeatherDetails || viewModel.details != nil {
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
