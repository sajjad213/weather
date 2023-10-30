//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import SwiftUI
import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var location: String = ""
    @Published var currentWeather: CurrectWeather?
    @Published var dailyForecast: [Forecast] = []
    @Published var isSearching = false
    @Published var error: String?
    @Published var searchText: String = ""
    @Published var isShowingSearchResults = false
    @Published var searchResults: [CLPlacemark] = []
    @Published var selectedResult: CLPlacemark? {
        didSet {
            guard let selectedResult else { return }
            reset()
            location = selectedResult.name ?? selectedResult.locality ?? selectedResult.country ?? ""
            fetchWeatherData(placemark: selectedResult)
        }
    }
    private var cancellables: Set<AnyCancellable> = []
    let weatherAPI: WeatherAPIProtocol
    
    init(weatherAPI: WeatherAPIProtocol) {
        self.weatherAPI = weatherAPI
        observeSearch()
    }
    
    private func observeSearch() {
        $searchText
            .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] text in
                guard !text.isEmpty else { return }
                self?.isShowingSearchResults = true
                self?.searchLocation(text: text)
            }
            .store(in: &cancellables)
    }
    
    private func resetSearch() {
        searchText = ""
        searchResults = []
        selectedResult = nil
        isShowingSearchResults = false
    }
    
    private func reset() {
        resetSearch()
        currentWeather = nil
        dailyForecast = []
        error = nil
    }
    
    func onStartSearching() {
        error = nil
        isShowingSearchResults = true
    }
    
    func onSearchBack() {
        resetSearch()
    }
    
    func searchLocation(text: String) {
        error = nil
        isSearching = true
        CLGeocoder().geocodeAddressString(text) { [weak self] placemarks, error in
            DispatchQueue.main.async { [weak self] in
                self?.searchResults = placemarks ?? []
            }
        }
    }
    
    private func fetchWeatherData(placemark: CLPlacemark) {
        guard let coordinates = placemark.location?.coordinate else {
            self.error = "Location not found!"
            self.isSearching = false
            return
        }
        
        let parameters = WeatherRequestParams(lat: coordinates.latitude, lon: coordinates.longitude)
        
        Task {
            do {
                let weather = (try await weatherAPI.fetchWeatherData(params: parameters)).toCurrectWeather()
                let forecast = (try await weatherAPI.fetchForecacstData(params: parameters)).toForecasts()
                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = weather
                    self?.dailyForecast = forecast
                    self?.isSearching = false
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.error = "Something went wrong!"
                    self?.isSearching = false
                }
            }
        }
    }
}
