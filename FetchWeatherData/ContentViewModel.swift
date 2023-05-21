//
//  ContentViewModel.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var weatherData: WeatherData? = nil
    @Published var shouldShowIndicator: Bool = false
    @Published var error: APIError?
    @Published var shouldShowAlert = false
    
    private let fetcher = WeatherDataFetcher()
    
    func fetchWeatherData() {
        Task { @MainActor in
            shouldShowIndicator = true
            defer {
                shouldShowIndicator = false
            }
//            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            do {
                weatherData = try await fetcher.fetchWeatherData()
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
