//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Sajjad Khazraei on 10/28/23.
//

import XCTest
@testable import Weather
import Combine

final class WeatherTests: XCTestCase {
    private var sut: WeatherViewModel!
    private var weatherApiMock: WeatherAPIProtocol!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        //
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellables.forEach { $0.cancel() }
        cancellables = []
    }

    func testSearchLocation() throws {
        weatherApiMock = WeatherApiMock()
        sut = WeatherViewModel(weatherAPI: weatherApiMock)
        
        let resultExpectation = expectation(description: "should return result for entered query!")
        let showingSearchResultsExpectation = expectation(description: "should show search result!")
        let searchingExpectation = expectation(description: "should show searching indicator!")
        sut.$isShowingSearchResults
            .sink { value in
                guard value else { return }
                showingSearchResultsExpectation.fulfill()
            }
            .store(in: &cancellables)
        sut.$isSearching
            .sink { value in
                guard value else { return }
                searchingExpectation.fulfill()
            }
            .store(in: &cancellables)
        sut.$searchResults
            .sink { [unowned self] places in
                guard places.isEmpty else { return }
                XCTAssertFalse(self.sut.isShowingSearchResults)
                XCTAssertFalse(self.sut.isSearching)
                XCTAssertNil(self.sut.error)
                resultExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.searchText = "Tehran"
        wait(for: [resultExpectation, showingSearchResultsExpectation, searchingExpectation], timeout: 3)
    }
}

struct WeatherApiMock: WeatherAPIProtocol {
    func fetchWeatherData(params: WeatherRequestParams) async throws -> WeatherResponse {
        WeatherResponse.stub()
    }
    
    func fetchForecacstData(params: WeatherRequestParams) async throws -> ForecastResponse {
        ForecastResponse.stub()
    }
}

struct WeatherApiWithErrorMock: WeatherAPIProtocol {
    func fetchWeatherData(params: WeatherRequestParams) async throws -> WeatherResponse {
        throw APIError.invalidReponse
    }
    
    func fetchForecacstData(params: WeatherRequestParams) async throws -> ForecastResponse {
        throw APIError.invalidData
    }
}
