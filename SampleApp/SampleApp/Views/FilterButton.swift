//
//  FilterButton.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import SwiftUI

struct FilterButton: View {
    @ObservedObject var viewModel: CountriesViewModel
    
    var filter: PopulationCountFilter
    
    var body: some View {
        Button(action: {
            if viewModel.selectedCountFilter == filter {
                viewModel.selectedCountFilter = nil
            } else {
                viewModel.selectedCountFilter = filter
            }
        }, label: {
            HStack {
                Text(filter.rawValue)
                if viewModel.selectedCountFilter == filter {
                    Image(systemName: "checkmark.circle.fill")
                }
            }
        })
    }
}
