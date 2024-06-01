//
//  ApiConstants.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation

enum ApiConstants {
    static let baseURL = "https://api.sampleapis.com"
    static let randomNoImageUrl = "https://sample.com"
}

enum NetworkServiceError: Error {
    case invalidURL
    case invalidStatusCode
}

enum HTTPMethodType: String {
    case get
}
