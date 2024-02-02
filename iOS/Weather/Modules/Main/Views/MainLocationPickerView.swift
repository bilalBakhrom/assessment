//
//  MainLocationPickerView.swift
//  Weather
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import SwiftUI
import AppUIKit
import AppColors

struct MainLocationPickerView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: MainViewModel) {
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
                        dismiss.callAsFunction()
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
                .onChange(of: viewModel.query) { query in
                    Task { await viewModel.sendEvent(.fetchCities(query: query)) }
                }
                
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
