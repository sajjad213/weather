//
//  WeatherData.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import Foundation

struct CurrectWeather {
    let temp: Double
    let weather: String
    let icon: String
    let humidity: Int
    let windSpeed: Double
    let dt: Date
    
    static func stub() -> CurrectWeather {
        .init(temp: 13, weather: "Light rain", icon: "10d", humidity: 87, windSpeed: 7.72, dt: .now)
    }
}

struct Forecast: Identifiable {
    var id = UUID()
    let temp: Double
    let icon: String
    let dt: Date
    
    static func stub() -> Forecast {
        .init(temp: 13, icon: "10d", dt: .now)
    }
}
