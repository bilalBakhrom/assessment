//
//  View++.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import SwiftUI

extension View {
    public func onTapAction(count: Int = 1, perform action: @escaping @MainActor () async -> Void) -> some View {
        self.onTapGesture { Task { @MainActor in await action() } }
    }
}
