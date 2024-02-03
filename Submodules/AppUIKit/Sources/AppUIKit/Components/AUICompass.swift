//
//  AUICompass.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI
import AppColors

public struct AUICompass: View {
    public var currentValue: Double
    public let sweepAngle: Double = 360
    public let maximumValue: Int = 360
    public let stepsPerDivision: Int = 15
    
    public init(currentValue: Double) {
        self.currentValue = currentValue
    }
    
    private var dashCount: Int {
        return maximumValue / stepsPerDivision
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let dashWidth = geometry.size.height * 0.015
            let dashHeight = geometry.size.height * 0.07
            
            ZStack {
                ForEach(0..<dashCount * 2 + 1, id: \.self) { value in
                    makeDashes(
                        at: value,
                        totalTicks: dashCount * 2,
                        width: dashWidth,
                        height: dashHeight
                    )
                }
                
                HStack(spacing: .zero) {
                    Text("W")
                    
                    Rectangle()
                        .fill(Color.modulePrimaryLabel.opacity(0.1))
                        .frame(height: dashWidth)
                        .padding(dashWidth)
                        .frame(maxWidth: .infinity)
                    
                    Text("E")
                }
                .padding(dashHeight * 1.5)
                .font(.system(size: geometry.size.height * 0.12, weight: .semibold))
                .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
                
                VStack(spacing: .zero) {
                    Text("N")
                    
                    Rectangle()
                        .fill(Color.modulePrimaryLabel.opacity(0.1))
                        .frame(width: dashWidth)
                        .padding(dashWidth)
                        .frame(maxHeight: .infinity)
                    
                    Text("S")
                }
                .padding(dashHeight * 1.5)
                .font(.system(size: geometry.size.height * 0.12, weight: .semibold))
                .foregroundStyle(Color.modulePrimaryLabel.opacity(0.5))
                
                
                CompassNeedle()
                    .fill(Color.modulePrimaryLabel)
                    .frame(
                        width: geometry.size.height,
                        height: geometry.size.height * 0.015
                    )
                    .rotationEffect(.init(degrees: needleAngle(currentValue)), anchor: .center)
            }
            .frame(
                width: geometry.size.height,
                height: geometry.size.height
            )
        }
    }
    
    private func makeDashes(
        at tick: Int,
        totalTicks: Int,
        width: CGFloat = 5,
        height: CGFloat = 20
    ) -> some View {
        let startAngle = (sweepAngle / 2) * -1
        let stepper = sweepAngle / Double(totalTicks)
        let rotation = Angle.degrees(startAngle + stepper * Double(tick))
        
        return VStack {
            Rectangle()
                .fill(Color.modulePrimaryLabel.opacity(0.1))
                .frame(width: width, height: height)
            
            Spacer()
        }
        .rotationEffect(rotation)
    }
    
    private func needleAngle(_ val: Double) -> Double {
        return (val / Double(maximumValue)) * sweepAngle - (sweepAngle / 2) + 90
    }
}

#Preview {
    VStack(spacing: 40) {
        AUICompass(currentValue: 200)
            .frame(width: 100, height: 100)
        
        AUICompass(currentValue: 270)
            .frame(width: 200, height: 200)
    }
    .padding(12)
    .background(Color.moduleTertiaryBackground)
}
