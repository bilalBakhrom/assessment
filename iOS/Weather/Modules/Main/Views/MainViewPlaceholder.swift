//
//  MainViewPlaceholder.swift
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

struct MainViewPlaceholder: View {
    @Binding var isFetchingDetails: Bool
    
    @EnvironmentObject private var locationManager: LocationManager
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(isFetchingDetails: Binding<Bool>) {
        _isFetchingDetails = isFetchingDetails
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                VStack(spacing: 4) {
                    Text(locationManager.country ?? "Location")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(Color.modulePrimaryLabel)
                 
                    Text("--")
                        .font(.system(size: 100, weight: .thin))
                        .foregroundStyle(Color.modulePrimaryLabel)
                }
                .padding(.top, 60 + safeAreaInsets.top)
                
                Spacer()
            }
            
            if isFetchingDetails {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity)
        .background(LinearGradient.blueSkyGradient)
    }
}
