//
//  AUIPressure.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI
import AppColors
import AppAssets

public struct AUIPressure: View {
    public var value: Int
    
    private let minPressure: Int = 900
    private let maxiumValue: Int = 186
    private let stepValue: Int = 15
    
    public init(value: Int) {
        self.value = value
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 4) {
                AppIcon(.gauge)
                    .frame(width: 10, height: 10)
                
                Text("Pressure".uppercased())
                
                Spacer(minLength: .zero)
            }
            .font(.system(size: 10))
            .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
            
            GaugeView(
                valueLabel: "\(value)",
                unitLabel: "hPa",
                minLabel: "Low",
                maxLabel: "High",
                currentValue: Double(value - minPressure),
                maximumValue: maxiumValue,
                step: stepValue,
                sweepAngle: 245
            )
            .padding(.horizontal)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .clipShape(.rect(cornerRadius: 12))
    }
}
