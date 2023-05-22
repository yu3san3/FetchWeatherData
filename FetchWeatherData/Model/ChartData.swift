//
//  ChartData.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/22.
//

import Foundation

struct ChartData: Identifiable {
    var id: String { return name }
    let name: String
    let data: [TemperatureDataElement]
}

struct TemperatureDataElement: Identifiable {
    var id: String { return date }
    let date: String
    let temperature: Double
}
