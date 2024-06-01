//
//  CountriesViewModel.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation
import Combine

@MainActor
class CountriesViewModel: ObservableObject {
    private var allCountries: [Country]? = nil
    private var cancellables = Set<AnyCancellable>()
    
    @Published var countries: [Country]? = nil
    
    @Published var showErrorAlert: Bool = false
    @Published var errorText: String = ""
    
    @Published var searchText: String = ""
    
    @Published var selectedCountFilter: PopulationCountFilter? = nil
    
    private let service = NetworkService()
    
    init() {
        addSearchTextFieldSubscriber()
        addFilterCountSubscriber()
    }
    
    var isCountriesLoaded: Bool {
        allCountries != nil
    }
    
    var isCountriesAvailable: Bool {
        !(countries ?? []).isEmpty
    }
    
    var shouldShowHeaderView: Bool {
        !(allCountries ?? []).isEmpty
    }
    
    var hasErrorOccurred: Bool {
        !errorText.isEmpty
    }
    
    private func addSearchTextFieldSubscriber() {
        $searchText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (_) in
                self?.filterCountries()
            })
            .store(in: &cancellables)
    }
    
    private func addFilterCountSubscriber() {
        $selectedCountFilter
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (_) in
                self?.filterCountries()
            })
            .store(in: &cancellables)
    }
    
    func fetchCountriesInfo() async {
        do {
            self.showErrorAlert = false
            self.errorText = ""
            let allCountries = try await service.getCountries()
            self.allCountries = allCountries
            self.filterCountries()
            print("Countries fetched from the api")
        } catch {
            print(error)
            self.errorText = "\(Constants.countriesDataError): \(error.localizedDescription)"
            self.showErrorAlert = true
        }
    }
    
    private func filterCountries() {
        var filteredCountries: [Country]? = allCountries
        if selectedCountFilter != nil {
            filteredCountries = filteredCountries?.filter({ country in
                (country.population ?? 0) < selectedCountFilter!.populationLimit
            })
        }
        
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredCountries = filteredCountries?.filter({ country in
                country.name?.lowercased().contains(searchText.lowercased()) ?? true
            })
        }
        
        countries = filteredCountries
    }
}
