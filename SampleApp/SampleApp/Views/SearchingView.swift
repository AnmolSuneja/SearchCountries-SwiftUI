//
//  SearchingView.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import SwiftUI

struct SearchingView: View {
    @ObservedObject var viewModel: CountriesViewModel
    
    var body: some View {
        HStack {
            TextField(Constants.searchByCountryPlaceholder, text: $viewModel.searchText)
                .font(.headline)
                        
            Button(action: {
                viewModel.searchText = ""
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .opacity(viewModel.searchText.isEmpty ? 0 : 1)
            })
        }
        .frame(height: 44)
        .padding(.horizontal)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.leading)
    }
}
