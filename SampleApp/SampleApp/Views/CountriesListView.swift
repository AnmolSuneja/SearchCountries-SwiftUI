//
//  CountriesListView.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import SwiftUI

struct CountriesListView: View {
    @StateObject private var viewModel: CountriesViewModel = CountriesViewModel()
    
    @StateObject private var timeViewModel: TimeViewModel = TimeViewModel()

    var body: some View {
        VStack {
            Text(timeViewModel.currentTime)
            
            headerView
            
            countriesListingView
        }
        .alert(Constants.errorTitle, isPresented: $viewModel.showErrorAlert) {
            Button(Constants.btnOkTitle, role: .none) {}
        } message: {
            Text(viewModel.errorText)
        }
        .task {
            await viewModel.fetchCountriesInfo()
        }
        .refreshable {
            await viewModel.fetchCountriesInfo()
        }
        .navigationTitle(Constants.navBarTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var headerView: some View {
        
        HStack {
            SearchingView(viewModel: viewModel)
            
            Menu {
                
                FilterButton(viewModel: viewModel, filter: .oneMillion)
                
                FilterButton(viewModel: viewModel, filter: .fiveMillion)
                
                FilterButton(viewModel: viewModel, filter: .tenMillion)
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.title)
                    .padding(.horizontal)
            }
        }
        .frame(height: viewModel.shouldShowHeaderView ? 50 : 0)
        .clipped()
    }
    
    var countriesListingView: some View {
        ZStack {
            List {
                ForEach(viewModel.countries ?? []) { country in
                    CountryItemView(country: country)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            if viewModel.isCountriesLoaded {
                if !viewModel.isCountriesAvailable {
                    ContentUnavailableView(Constants.noCountriesFound, systemImage: "xmark")
                        .tint(Color.primary)
                }
            } else if !viewModel.hasErrorOccurred {
                ProgressView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CountriesListView()
    }
}
