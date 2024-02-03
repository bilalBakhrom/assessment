//
//  AUIGaugeView.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI
import AppColors

struct Needle: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: rect.height))
        
        let circleRadius = width / 5
        let origin = CGPoint(x: width - circleRadius / 2, y: (rect.height / 2) - (circleRadius / 2))
        let size = CGSize(width: circleRadius, height: circleRadius)
        path.addEllipse(in: CGRect(origin: origin, size: size))
        
        return path
    }
}

public struct GaugeView: View {
    public var valueLabel: String?
    public var unitLabel: String?
    public var minLabel: String?
    public var maxLabel: String?
    public var currentValue: Double
    public let sweepAngle: Double
    public let maximumValue: Int
    public let stepsPerDivision: Int
    
    public init(
        valueLabel: String? = nil,
        unitLabel: String? = nil,
        minLabel: String? = nil,
        maxLabel: String? = nil,
        currentValue: Double,
        maximumValue: Int,
        step: Int,
        sweepAngle: Double
    ) {
        self.valueLabel = valueLabel
        self.unitLabel = unitLabel
        self.minLabel = minLabel
        self.maxLabel = maxLabel
        self.currentValue = currentValue
        self.sweepAngle = sweepAngle
        self.maximumValue = maximumValue
        self.stepsPerDivision = step
    }
    
    private var tickCount: Int {
        return maximumValue / stepsPerDivision
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let needleWidth = geometry.size.width / 3
            
            ZStack {
                ForEach(0..<tickCount * 2 + 1, id: \.self) { value in
                    makeTick(
                        at: value,
                        totalTicks: tickCount * 2,
                        width: geometry.size.width * 0.015,
                        height: geometry.size.height * 0.07
                    )
                }
                
                VStack(spacing: geometry.size.height * 0.06) {
                    Needle()
                        .fill(Color.modulePrimaryLabel.opacity(0.5))
                        .frame(
                            width: needleWidth,
                            height: geometry.size.width * 0.03
                        )
                        .offset(x: needleWidth / -2)
                        .rotationEffect(.init(degrees: needleAngle(currentValue)), anchor: .center)
                    
                    VStack(spacing: .zero) {
                        if let valueLabel {
                            Text(valueLabel)
                                .font(.system(size: geometry.size.width * 0.15))
                                .foregroundStyle(Color.modulePrimaryLabel)
                        }
                        
                        if let unitLabel {
                            Text(unitLabel)
                                .font(.system(size: geometry.size.width * 0.08))
                                .foregroundStyle(Color.modulePrimaryLabel)
                        }
                    }
                }
                .offset(y: needleWidth / 3)
                
                VStack(spacing: .zero) {
                    Spacer(minLength: .zero)
                    
                    HStack(spacing: .zero) {
                        Spacer(minLength: .zero)
                        
                        if let minLabel {
                            Text(minLabel)
                        }
                        
                        Spacer(minLength: .zero)
                        
                        if let maxLabel {
                            Text(maxLabel)
                        }
                        
                        Spacer(minLength: .zero)
                    }
                    .font(.system(size: geometry.size.width * 0.1))
                    .foregroundStyle(Color.modulePrimaryLabel)
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
    }
    
    private func makeTick(
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
                .fill(Color.modulePrimaryLabel.opacity(0.5))
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
        GaugeView(
            valueLabel: "1024",
            minLabel: "Low",
            maxLabel: "High",
            currentValue: 1084 - 1015,
            maximumValue: 130,
            step: 10,
            sweepAngle: 245
        )
        .frame(width: 100, height: 100)
        
        GaugeView(
            valueLabel: "1024",
            unitLabel: "hPa",
            minLabel: "Low",
            maxLabel: "High",
            currentValue: 1084 - 1015,
            maximumValue: 130,
            step: 10,
            sweepAngle: 245
        )
        .frame(width: 300, height: 300)
    }
    .padding(12)
    .background(Color.moduleTertiaryBackground)
}
