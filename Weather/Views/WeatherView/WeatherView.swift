//
//  WeatherView.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/28/23.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @ObservedObject private var viewModel: WeatherViewModel
    
    enum Field: Hashable {
        case search
    }
    @FocusState private var focusedField: Field?
    
    public init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            SearchBar(searchText: $viewModel.searchText,
                      isShowingSearchResults: $viewModel.isShowingSearchResults) {
                viewModel.onStartSearching()
            } onBack: {
                viewModel.onSearchBack()
            }
            .focused($focusedField, equals: .search)
            
            if viewModel.isShowingSearchResults {
                SearchResultView(results: $viewModel.searchResults,
                                 selectedResult: $viewModel.selectedResult,
                                 isPresented: $viewModel.isShowingSearchResults)
            } else if let currentWeather = viewModel.currentWeather {
                WeatherLocationHeader(location: $viewModel.location, currentWeather: currentWeather)
                WeatherDetailsView(currentWeather: currentWeather)
                ForecastView(forecast: viewModel.dailyForecast)
            } else {
                if viewModel.isSearching {
                    ProgressView("Searching...")
                        .padding(.top, 32)
                } else {
                    Text("Enter a location to see the weather")
                        .padding(.top, 32)
                }
            }
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 32)
            }
            
            Spacer()
        }
        .padding(20)
        .onReceive(viewModel.$isShowingSearchResults, perform: { value in
            if !value {
                focusedField = nil
            }
        })
    }
}

//#Preview {
//    WeatherView()
//}
