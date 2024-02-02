//
//  AUISearchBar.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import SwiftUI

public struct MUISearchView: View {
    // MARK: - Property Wrappers
    @Binding public var searchString: String
    @Binding private var isSearchBarActive: Bool
    public var onSubmit: (() async -> Void)?
    public var onCancel: (() async -> Void)?
    
    @Environment(\.windowSize) private var windowSize
    private let configuration = Configuration()
    
    private var showsSearchGlass: Bool {
        return isSearchBarActive || searchString.isEmpty
    }
    
    public init(
        searchString: Binding<String>,
        isSearchBarActive: Binding<Bool>,
        onSubmit: (() async -> Void)? = nil,
        onCancel: (() async -> Void)? = nil
    ) {
        _searchString = searchString
        _isSearchBarActive = isSearchBarActive
        self.onSubmit = onSubmit
        self.onCancel = onCancel
    }
    
    // MARK: - Content
    public var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 23)
                    .fill(Color.modulePrimaryBackground)
                
                searchContent
            }
            .frame(height: 36)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 23)
                    .inset(by: 1)
                    .stroke(isSearchBarActive ? Color.white : Color.moduleGray, lineWidth: 2)
            )
            
            if isSearchBarActive {
                cancelButton
            }
        }
        .animation(.easeIn(duration: 0.15), value: isSearchBarActive)
    }
    
    private var searchContent: some View {
        HStack(spacing: 10) {
            if showsSearchGlass {
                Image(systemName: "magnifyingglass")
                    .frame(
                        width: configuration.iconSize,
                        height: configuration.iconSize,
                        alignment: .center
                    )
                    .foregroundColor(isSearchBarActive ? Color.white : Color.moduleGray)
            }
            
            GeometryReader { geometry in
                TextFieldWrapper(
                    "Search for a city",
                    text: $searchString,
                    isActive: $isSearchBarActive,
                    onSubmit: handleSubmitButtonClick
                )
                .frame(width: geometry.size.width, alignment: .trailing)
                .clipped()
            }
            .frame(height: 46)
            
            if !searchString.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: configuration.iconSize))
                    .foregroundStyle(Color.moduleGray)
                    .onTapGesture {
                        searchString = ""
                    }
            }
        }
        .padding(.leading, configuration.leadingPadding)
        .padding(.trailing, configuration.trailingPadding)
    }
    
    private var cancelButton: some View {
        Button {
            isSearchBarActive = false
            searchString = ""
        } label: {
            Text("Cancel")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.modulePrimaryLabel)
        }
    }
    
    // MARK: Helper Methods
    
    private func handleSubmitButtonClick() {
        isSearchBarActive = false
        Task { await onSubmit?() }
    }
    
    private func handleCancelButtonClick() {
        searchString = ""
        isSearchBarActive = false
        Task { await onCancel?() }
    }
}

extension MUISearchView {
    struct Configuration {
        let leadingPadding: CGFloat = 20
        let trailingPadding: CGFloat = 16
        let iconSize: CGFloat = 20
    }
}
