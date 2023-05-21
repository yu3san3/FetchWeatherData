//
//  WeatherData.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let daily: Daily
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case daily
    }
}

struct Daily: Codable {
    let time: [String]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
    }
}
