//
//  Needle.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI

public struct Needle: Shape {
    public func path(in rect: CGRect) -> Path {
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
