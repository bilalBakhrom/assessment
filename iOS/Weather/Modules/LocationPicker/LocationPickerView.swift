//
//  LocationPickerView.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-04.
//

import SwiftUI
import AppUIKit

struct LocationPickerView: View {
    @ObservedObject var viewModel: LocationPickerViewModel
    
    init(viewModel: LocationPickerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.modulePrimaryBackground)
            
            VStack(spacing: .zero) {
                HStack(spacing: .zero) {
                    Spacer()
                    
                    Button {
                        Task { await viewModel.sendEvent(.onTapCloseButton) }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.modulePrimaryLabel)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                MUISearchView(
                    searchString: $viewModel.query,
                    isSearchBarActive: $viewModel.isSearchBarActive
                )
                .padding(.horizontal, 20)
                .padding(.bottom)                
                
                if !viewModel.cities.isEmpty {
                    AUIList {
                        ForEach(viewModel.cities) { city in
                            HStack(spacing: .zero) {
                                Text(city.name)
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.modulePrimaryLabel)
                                    .onTapAction {
                                        await viewModel.sendEvent(.onTapCity(city: city))
                                    }
                                
                                Spacer(minLength: .zero)
                            }
                            .contentShape(.rect)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .background(Color.clear)
                }
                
                Spacer(minLength: .zero)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.modulePrimaryBackground)
    }
}
