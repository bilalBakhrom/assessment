//
//  AUILocationAccessNeeded.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-01.
//

import SwiftUI
import AppColors

public struct AUILocationAccessNeeded: View {
    public var onRequest: @MainActor () async -> Void
    
    private var linearGradient: LinearGradient {
        let firstColor: Color = .moduleSecondaryAccent
        let secondColor: Color = .moduleAccent
        
        return LinearGradient(
            gradient: Gradient(colors: [firstColor, secondColor]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    public init(onRequest: @escaping @MainActor () async -> Void) {
        self.onRequest = onRequest
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            Text("Location access is needed to show weather near you")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.modulePrimaryLabel)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                Task { @MainActor in await onRequest() }
            } label: {
                Text("Open Settings")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 42)
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.bottom, 40)
        }
        .padding(.horizontal)
        .background(linearGradient)
    }
}
