//
//  ChartData.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/22.
//

import Foundation

struct ChartData: Identifiable {
    var id: String { return chartName }
    let chartName: String
    let data: [TemperatureDataElement]
}

struct TemperatureDataElement: Identifiable {
    var id: String { return date }
    let date: String
    let temperature: Double
}
