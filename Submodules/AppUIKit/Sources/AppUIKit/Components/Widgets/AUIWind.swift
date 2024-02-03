//
//  AUIWind.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI
import AppColors
import AppModels

public struct AUIWind: View {
    public var speed: Double
    public var gust: Double
    public var degree: Double
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.groupingSeparator = ","
        
        return formatter
    }()
    
    private var vwSpeed: String {
        guard speed != .notAvailable else { return "0" }
        return numberFormatter.string(from: NSNumber(value: speed)) ?? "-"
    }
    
    private var vwGust: String {
        guard gust != .notAvailable else { return "0" }
        return numberFormatter.string(from: NSNumber(value: gust)) ?? "-"
    }
    
    public init(speed: Double, gust: Double, degree: Double) {
        self.speed = speed
        self.gust = gust
        self.degree = degree
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 4) {
                Image(systemName: "wind")
                
                Text("Wind".uppercased())
                
                Spacer(minLength: .zero)
            }
            .font(.system(size: 10))
            .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
            
            windSpeedView
            
            Rectangle()
                .fill(Color.modulePrimaryLabel.opacity(0.5))
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
            
            windGustView
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
    
    private var windSpeedView: some View {
        HStack(spacing: 8) {
            Text(vwSpeed)
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(Color.modulePrimaryLabel)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("M/S")
                    .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
                                
                Text("Wind")
                    .foregroundStyle(Color.modulePrimaryLabel)
            }
            .font(.system(size: 12))
        }
    }
    
    private var windGustView: some View {
        HStack(spacing: 8) {
            Text(vwGust)
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(Color.modulePrimaryLabel)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("M/S")
                    .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
                                
                Text("Gusts")
                    .foregroundStyle(Color.modulePrimaryLabel)
            }
            .font(.system(size: 12))
        }
    }
}
