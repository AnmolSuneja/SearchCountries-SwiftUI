//
//  Country.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation

struct Country: Decodable, Identifiable {
    let id: Int
    let name: String?
    let capital: String?
    let currency: String?
    let media: Media?
    
    let population: Int?
    
    var populationText: String {
        guard let population else {
            return Constants.missingFieldPlaceholder
        }
        return "\(population)"
    }
    
    var flagUrl: String {
        media?.flag ?? ApiConstants.randomNoImageUrl
    }
}

struct Media: Decodable {
    let flag: String?
}
