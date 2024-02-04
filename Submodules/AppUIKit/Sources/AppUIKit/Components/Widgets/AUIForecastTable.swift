//
//  AUIForecastTable.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-05.
//

import SwiftUI
import AppColors
import AppModels

public struct AUIForecastTable: View {
    public var forecasts: [Forecast]
    
    public init(forecasts: [Forecast]) {
        self.forecasts = forecasts
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: 4) {
                Image(systemName: "calendar")
                
                Text("\(forecasts.count)-day forecast".uppercased())
                
                Spacer(minLength: .zero)
            }
            .font(.system(size: 10))
            .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
            .padding(.vertical, 12)
            
            ForEach(forecasts) { forecast in
                Rectangle()
                    .fill(Color.moduleStrokeColor.opacity(0.5))
                    .frame(height: 0.5)
                    .frame(maxWidth: .infinity)
                
                HStack {
                    Text(forecast.formattedDateByWeekName)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Text(forecast.vwTempMin)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.moduleSecondaryBackground)
                            .frame(width: 100, height: 4)
                        
                        Text(forecast.vwTempMax)
                    }
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.modulePrimaryLabel)
                .padding(.vertical, 12)
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .clipShape(.rect(cornerRadius: 12))
    }
}
