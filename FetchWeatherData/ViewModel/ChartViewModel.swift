//
//  ChartViewModel.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/23.
//

import Foundation

final class ChartViewModel: ObservableObject {
    
    @Published var chartData: [ChartData] = []
    
    func generateChartData(weatherData: WeatherData) {
        let maxTemperatureData: [TemperatureDataElement] = zip(weatherData.daily.time, weatherData.daily.temperature2mMax)
            .map { (date, temperature) in
                return TemperatureDataElement(date: date, temperature: temperature)
            }
        let minTemperatureData: [TemperatureDataElement] = zip(weatherData.daily.time, weatherData.daily.temperature2mMin)
            .map { (date, temperature) in
                return TemperatureDataElement(date: date, temperature: temperature)
            }
        chartData = [
            ChartData(name: "最高気温", data: maxTemperatureData),
            ChartData(name: "最低気温", data: minTemperatureData)
        ]
    }
}
