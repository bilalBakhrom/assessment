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
        VStack(spacing: .zero) {
            Spacer()
            
            if locationManager.isNotAuthorized {
                Button {
                    viewModel.showLocationDisabledAlert = true
                } label: {
                    Text("We need your permission")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.modulePrimaryLabel)
                }
                .padding(.horizontal, 12)
                .frame(height: 52)
                .background(Color.moduleSecondaryAccent)
                .opacity(0.8)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.bottom, 12)
            }
        }
        .alert(isPresented: $viewModel.showLocationDisabledAlert) {
            Alert(
                title: Text("Location Permission Denied"),
                message: Text("Please enable location services in Settings."),
                primaryButton: .cancel(),
                secondaryButton: .default(Text("Open Settings"), action: {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                })
            )
        }
    }
}
