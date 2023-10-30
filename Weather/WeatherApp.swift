//
//  WeatherApp.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/28/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherApi = WeatherAPI()
            let weatherViewModel = WeatherViewModel(weatherAPI: weatherApi)
            WeatherView(viewModel: weatherViewModel)
        }
    }
}
