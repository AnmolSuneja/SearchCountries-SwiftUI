//
//  PopulationCountFilter.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation

enum PopulationCountFilter: String {
    case oneMillion = "< 1M"
    case fiveMillion = "< 5M"
    case tenMillion = "< 10M"
    
    var populationLimit: Int {
        switch self {
        case .oneMillion:
            return 1000000
        case .fiveMillion:
            return 5000000
        case .tenMillion:
            return 10000000
        }
    }
}
