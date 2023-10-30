//
//  Endpoints.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/30/23.
//

import Foundation

enum Endpoints {
    case weather
    case forecast
    
    var baseURL: String {
        "https://api.openweathermap.org/data/2.5"
    }
    
    var path: String {
        switch self {
        case .weather:
            "/weather"
        case .forecast:
            "/forecast"
        }
    }
    
    var url: String {
        "\(baseURL)\(path)"
    }
}
