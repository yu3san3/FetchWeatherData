//
//  ContentViewModel.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var cityData: CityData?
    
    @Published var shouldShowIndicator: Bool = false
    @Published var shouldShowAlert = false
    @Published var error: APIError?
    
    private let weatherDataFetcher = WeatherDataFetcher()
    private let cityDataFetcher = CityDataFetcher()
    
    func fetchWeatherData() {
        Task { @MainActor in
            shouldShowIndicator = true
            defer {
                shouldShowIndicator = false
            }
         
            do {
                weatherData = try await weatherDataFetcher.fetchWeatherData()
            } catch {
                if let apiError = error as? APIError {
                    self.error = apiError
                    shouldShowAlert = true
                } else if let error = error as? URLError, error.code == URLError.notConnectedToInternet {
                    self.error = APIError.network
                    shouldShowAlert = true
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchCityData() {
        Task { @MainActor in
            shouldShowIndicator = true
            defer {
                shouldShowIndicator = false
            }
            
            do {
                cityData = try await cityDataFetcher.fetchCityData()
            } catch {
                if let apiError = error as? APIError {
                    self.error = apiError
                    shouldShowAlert = true
                } else if let error = error as? URLError, error.code == URLError.notConnectedToInternet {
                    self.error = APIError.network
                    shouldShowAlert = true
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
