//
//  WeatherDataFetcher.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import Foundation

final class WeatherDataFetcher {
    
    let locationManager = LocationManager()
    
    private var currentLatitude: Double {
        locationManager.location.coordinate.latitude
    }
    private var currentLongitude: Double {
        locationManager.location.coordinate.longitude
    }
    var url: URL {
        URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(currentLatitude)&longitude=\(currentLongitude)&daily=temperature_2m_max,temperature_2m_min&past_days=7&forecast_days=2&timezone=Asia%2FTokyo")!
    }
    
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
