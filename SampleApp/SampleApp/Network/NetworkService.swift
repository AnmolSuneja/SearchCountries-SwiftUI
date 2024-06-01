//
//  NetworkService.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation

actor NetworkService {
    func getCountries() async throws -> [Country] {
        let countries: [Country] = try await executeRequest(for: Endpoint.countries)
        return countries
    }
    
    private func executeRequest<T: Decodable>(for api: Endpoint) async throws -> T {
        guard let url = URL(string: api.fullPath) else {
            throw NetworkServiceError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw NetworkServiceError.invalidStatusCode
        }
        let parsedData = try JSONDecoder().decode(T.self, from: data)
        return parsedData
    }
}

/*
 //https://api.sampleapis.com/countries/countries
 Sample Response:
 [
     {
         "abbreviation": "BD",
         "capital": "Dhaka",
         "currency": "BDT",
         "name": "Bangladesh",
         "phone": "880",
         "population": 162951560,
         "media": {
             "flag": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/1280px-Flag_of_Bangladesh.svg.png",
             "emblem": "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/National_emblem_of_Bangladesh.svg/1280px-National_emblem_of_Bangladesh.svg.png",
             "orthographic": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bangladesh_%28orthographic_projection%29.svg/1280px-Bangladesh_(orthographic_projection).svg.png"
         },
         "id": 1
     },
     {
         "abbreviation": "BE",
         "capital": "Brussels",
         "currency": "EUR",
         "name": "Belgium",
         "phone": "32",
         "population": 11348159,
         "media": {
             "flag": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Belgium.svg/1182px-Flag_of_Belgium.svg.png",
             "emblem": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Great_coat_of_arms_of_Belgium.svg/1280px-Great_coat_of_arms_of_Belgium.svg.png",
             "orthographic": ""
         },
         "id": 2
     }
 ]
 */
