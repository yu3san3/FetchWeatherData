//
//  TemperatureData.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/22.
//

import Foundation

struct TemperatureData: Identifiable {
    var id: String { return chartType }
    let chartType: String
    let data: [TemperatureDataElement]
}

struct TemperatureDataElement: Identifiable {
    var id: String { return date }
    let date: String
    let temperature: Double
}
