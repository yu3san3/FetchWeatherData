//
//  CityDataFetcher.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/24.
//

import Foundation

final class CityDataFetcher {
    
    let locationManager = LocationManager()
    
    private var currentLatitude: Double {
        locationManager.location.coordinate.latitude
    }
    private var currentLongitude: Double {
        locationManager.location.coordinate.longitude
    }
    var url: URL {
        URL(string: "https://geoapi.heartrails.com/api/json?method=searchByGeoLocation&x=\(currentLongitude)&y=\(currentLatitude)")!
    }
    
    func fetchCityData() async throws -> CityData {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.response
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let resultData = try JSONDecoder().decode(CityData.self, from: data)
                return resultData
            } catch {
                throw APIError.jsonDecode
            }
        default:
            throw APIError.statusCode(statusCode: httpResponse.statusCode.description)
        }
    }
}
