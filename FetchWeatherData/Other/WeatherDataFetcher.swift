//
//  WeatherDataFetcher.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import Foundation

final class WeatherDataFetcher {
    
    let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=35.30&longitude=136.80&daily=temperature_2m_max,temperature_2m_min&past_days=7&forecast_days=2&timezone=Asia%2FTokyo")!
    
    func fetchWeatherData() async throws -> WeatherData {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.response
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let resultData = try JSONDecoder().decode(WeatherData.self, from: data)
                return resultData
            } catch {
                throw APIError.jsonDecode
            }
        default:
            throw APIError.statusCode(statusCode: httpResponse.statusCode.description)
        }
    }
}
