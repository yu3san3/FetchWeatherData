//
//  ContentViewModel.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    private var maxTemperatureData: [TemperatureDataElement] = []
    private var minTemperatureData: [TemperatureDataElement] = []
    @Published var temperatureData: [TemperatureData] = []
    
    @Published var shouldShowIndicator: Bool = false
    @Published var shouldShowAlert = false
    @Published var error: APIError?
    
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
                maxTemperatureData = zip(weatherData!.daily.time, weatherData!.daily.temperature2mMax)
                    .map { (date, temperature) in
                        return TemperatureDataElement(date: date, temperature: temperature)
                    }
                minTemperatureData = zip(weatherData!.daily.time, weatherData!.daily.temperature2mMin)
                    .map { (date, temperature) in
                        return TemperatureDataElement(date: date, temperature: temperature)
                    }
                temperatureData = [
                    TemperatureData(chartType: "最高気温", data: maxTemperatureData),
                    TemperatureData(chartType: "最低気温", data: minTemperatureData)
                ]
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
