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

let mockWeatherData: WeatherData = WeatherData(
    latitude: 35.3,
    longitude: 136.8125,
    daily:
        Daily(
            time: ["2023-05-15", "2023-05-16", "2023-05-17", "2023-05-18", "2023-05-19", "2023-05-20", "2023-05-21", "2023-05-22"],
            temperature2mMax: [23.0, 28.2, 32.2, 29.7, 19.3, 28.1, 28.8, 27.1],
            temperature2mMin: [14.9, 13.2, 14.2, 15.7, 17.2, 17.8, 16.9, 17.3]
        )
)

