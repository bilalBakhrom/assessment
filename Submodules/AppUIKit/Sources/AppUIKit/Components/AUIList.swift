//
//  AUIList.swift
//  
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import SwiftUI

public struct AUIList<Content: View>: View {
    public let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            List {
                content()
            }
            .scrollIndicators(.hidden, axes: .vertical)
            .scrollContentBackground(.hidden)
        } else {
            List {
                content()
            }
            .background(Color.clear)
        }
    }
}
