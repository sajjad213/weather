//
//  WeatherAPI.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import Foundation
import CoreLocation

protocol WeatherAPIProtocol {
    func fetchWeatherData(params: WeatherRequestParams) async throws -> WeatherResponse
    func fetchForecacstData(params: WeatherRequestParams) async throws -> ForecastResponse
}

struct WeatherAPI: WeatherAPIProtocol {
    func fetchWeatherData(params: WeatherRequestParams) async throws -> WeatherResponse {
        let apiRequest = APIRequest(url: Endpoints.weather.url,
                                    params: params.dictionary)
        return try await apiRequest.perform()
    }
    
    func fetchForecacstData(params: WeatherRequestParams) async throws -> ForecastResponse {
        let apiRequest = APIRequest(url: Endpoints.forecast.url,
                                    params: params.dictionary)
        return try await apiRequest.perform()
    }
}

class WeatherRequestParams: RequestParamsModel {
    let lat: Double
    let lon: Double
    let units: String
    
    init(lat: Double, lon: Double, units: String = "metric") {
        self.lat = lat
        self.lon = lon
        self.units = units
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(units, forKey: .units)
        try super.encode(to: encoder)
    }
    
    public enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case units
    }
}
