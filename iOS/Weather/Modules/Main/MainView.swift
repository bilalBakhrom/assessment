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
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if locationManager.isNotAuthorized {
            AUILocationAccessNeeded {
                await viewModel.sendEvent(.openSettings)
            }
            .ignoresSafeArea()
        } else {
            if viewModel.isFetchingWeatherDetails {
                ZStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.modulePrimaryBackground)
            } else {
                content
            }
        }
    }
    
    private var content: some View {
        VStack(spacing: .zero) {
            VStack(spacing: 8) {
                VStack(spacing: 4) {
                    Text("My Location")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(Color.modulePrimaryLabel)
                    
                    Text(String(locationManager.placeMark?.country ?? viewModel.weatherDetails?.name ?? "").uppercased())
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.modulePrimaryLabel)
                }
                
                Text("\(viewModel.weatherDetails?.temp ?? 0)°")
                    .font(.system(size: 100, weight: .medium))
                    .foregroundStyle(Color.modulePrimaryLabel)
                
                VStack(spacing: 4) {
                    Text(viewModel.weatherDetails?.description ?? "")
                    
                    if let tempMax = viewModel.weatherDetails?.tempMax,
                       let tempMin = viewModel.weatherDetails?.tempMin {
                        Text("H: \(tempMax)°  L: \(tempMin)°")
                    }
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.modulePrimaryLabel)
            }
            .padding(.top, 60 + safeAreaInsets.top)
            
            if !viewModel.isFetchingWeatherDetails {
                Text(viewModel.weatherDetails?.recommendation ?? "")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.modulePrimaryLabel)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 40)
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
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.modulePrimaryBackground)
        .sheet(isPresented: $viewModel.isLocationPickerPresented) {
            MainLocationPickerView(viewModel: viewModel)
                .background(Color.modulePrimaryBackground)
        }
    }
}
