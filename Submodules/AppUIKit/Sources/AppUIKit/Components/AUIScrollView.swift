//
//  AUIScrollView.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-03.
//

import SwiftUI

public struct AUIScrollView<Content: View>: View {
    @Binding public var scrollPosition: CGPoint
    private let content: () -> Content
    private let coordinateSpace: String = "AUIScrollViewCoordinateSpace"
    
    public init(scrollPosition: Binding<CGPoint>, content: @escaping () -> Content) {
        self._scrollPosition = scrollPosition
        self.content = content
    }
    
    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(showsIndicators: false) {
                content()
                    .background(
                        GeometryReader { geometry in
                            let value = geometry.frame(in: .named(coordinateSpace)).origin
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: value)
                        }
                    )
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        scrollPosition = value
                    }
            }
            .coordinateSpace(name: coordinateSpace)
        }
    }
}
