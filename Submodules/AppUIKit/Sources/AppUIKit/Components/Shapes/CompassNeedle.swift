//
//  CompassNeedle.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI

public struct CompassNeedle: Shape {
    public func path(in rect: CGRect) -> Path {
        // Needle base
        let width = rect.width
        let height = rect.height
        let circleRadius = width * 0.06
        let startPointX = width - circleRadius / 2
        
        // Arrowhead base
        let arrowWidth = width * 0.1
        let arrowHeight = width * 0.1
        let arrowTip = CGPoint(x: 0, y: height / 2) // Arrow tip starts at the base now
        let arrowRightBase = CGPoint(x: arrowWidth, y: arrowHeight / 2)
        let arrowCenterBase = CGPoint(x: arrowWidth / 1.3, y: arrowTip.y / 2)
        let arrowLeftBase = CGPoint(x: arrowWidth, y: -(arrowHeight / 2))
        
        var arrowPath = Path()
        arrowPath.move(to: arrowTip)
        arrowPath.addLine(to: arrowRightBase)
        arrowPath.addLine(to: arrowCenterBase)
        arrowPath.addLine(to: arrowLeftBase)
        arrowPath.addLine(to: arrowTip)
        arrowPath.closeSubpath()
                
        // Needle body
        var path = Path()
        path.move(to: CGPoint(x: arrowCenterBase.x, y: 0))
        path.addLine(to: CGPoint(x: startPointX, y: 0))
        path.addLine(to: CGPoint(x: startPointX, y: height))
        path.addLine(to: CGPoint(x: arrowCenterBase.x, y: height))
        
        // Circle at the end
        let circleOrigin = CGPoint(x: startPointX, y: (height / 2) - (circleRadius / 2))
        let circleSize = CGSize(width: circleRadius, height: circleRadius)
        path.addEllipse(in: CGRect(origin: circleOrigin, size: circleSize))
        
        path.addPath(arrowPath)
        
        return path
    }
}
