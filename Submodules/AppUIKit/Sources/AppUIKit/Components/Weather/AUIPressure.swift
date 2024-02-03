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
    public var value: String
    public var recommendation: String
    
    public init(value: String, recommendation: String) {
        self.value = value
        self.recommendation = recommendation
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
            .foregroundStyle(Color.modulePrimaryLabel)
            .opacity(0.7)
            
            Text(value)
                .font(.system(size: 32))
                .foregroundStyle(Color.modulePrimaryLabel)
            
            Spacer(minLength: .zero)
            
            Text(recommendation)
                .font(.system(size: 12))
                .foregroundStyle(Color.modulePrimaryLabel)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.moduleTertiaryBackground.opacity(0.5))
        .clipShape(.rect(cornerRadius: 12))
    }
}
