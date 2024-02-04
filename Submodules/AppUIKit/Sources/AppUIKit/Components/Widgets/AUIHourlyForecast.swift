//
//  AUIHourlyForecast.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-05.
//

import SwiftUI
import AppColors
import AppModels

public struct AUIHourlyForecast: View {
    public var forecasts: [Forecast]
    
    public init(forecasts: [Forecast]) {
        self.forecasts = forecasts
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                Image(systemName: "clock")
                
                Text("Hourly forecast".uppercased())
                
                Spacer(minLength: .zero)
            }
            .font(.system(size: 10))
            .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
            .padding(.horizontal, 16)
            
            GeometryReader { geometry in
                let itemsCount: CGFloat = 7
                let hPadding: CGFloat = 16
                let itemWidth = (geometry.size.width - hPadding * 2 - (itemsCount - 1) * 8) / itemsCount
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .zero) {
                        Spacer(minLength: hPadding)
                        
                        HStack(spacing: 8) {
                            ForEach(forecasts) { forecast in
                                VStack(spacing: 8) {
                                    Text(forecast.formattedDate)
                                        .font(.system(size: 13, weight: .medium))
                                    
                                    ZStack {
                                        Image(systemName: "aqi.medium")
                                            .font(.system(size: 16))
                                    }
                                    .frame(width: 24, height: 24)
                                    
                                    Text("\(forecast.vwTemp)")
                                        .font(.system(size: 15, weight: .medium))
                                }
                                .foregroundStyle(Color.modulePrimaryLabel)
                                .frame(width: itemWidth)
                            }
                        }
                        
                        Spacer(minLength: hPadding)
                    }
                }
            }
            .frame(height: 80)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .clipShape(.rect(cornerRadius: 12))
    }
}
