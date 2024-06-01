//
//  Endpoint.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation

enum Endpoint {
    case countries
}

extension Endpoint {
    var fullPath: String {
        ApiConstants.baseURL + path
    }
    
    var method: String {
        httpMethod.rawValue.uppercased()
    }
}

private extension Endpoint {
    var path: String {
        switch self {
        case .countries:
            return "/countries/countries"
        }
    }
    
    var httpMethod: HTTPMethodType {
        switch self {
        case .countries:
            return .get
        }
    }
}
