//
//  WeatherAPIResponse.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let dt: Double
    
    func toCurrectWeather() -> CurrectWeather {
        CurrectWeather(temp: main.temp, weather: weather.first?.description ?? "", icon: weather.first?.icon ?? "", humidity: main.humidity, windSpeed: wind.speed, dt: Date.init(timeIntervalSince1970: dt))
    }
    
    static func stub() -> WeatherResponse {
        .init(weather: [.init(main: "Rain", description: "Light rain", icon: "10d")], 
              main: .init(temp: 13, humidity: 87),
              wind: .init(speed: 7.72),
              dt: 100000000)
    }
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}

struct ForecastResponse: Codable {
    let list: [ForecastModel]
    
    func toForecasts() -> [Forecast] {
        list.map { $0.toForecast() }.filter { model in
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: model.dt)
            return hour == 12
        }
    }
    
    static func stub() -> ForecastResponse {
        .init(list: [ForecastModel.stub(), ForecastModel.stub(), ForecastModel.stub(), ForecastModel.stub(), ForecastModel.stub()])
    }
}

struct ForecastModel: Codable {
    let main: Main
    let weather: [Weather]
    let dt: Double
    
    func toForecast() -> Forecast {
        Forecast(temp: main.temp, icon: weather.first?.icon ?? "", dt: Date.init(timeIntervalSince1970: dt))
    }
    
    static func stub() -> ForecastModel {
        .init(main: .init(temp: 13, humidity: 87), weather: [.init(main: "Rain", description: "Light rain", icon: "10d")], dt: 100000000)
    }
}
