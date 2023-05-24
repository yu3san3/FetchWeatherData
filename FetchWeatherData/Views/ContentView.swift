//
//  ContentView.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            HStack {
                Text("緯度: \(locationManager.location.coordinate.latitude)")
                Text("経度: \(locationManager.location.coordinate.longitude)")
            }
//            HStack {
//                if let latitude = contentVM.weatherData?.latitude {
//                    Text("緯度 " + String(latitude) + ",")
//                }
//                if let longitude = contentVM.weatherData?.longitude {
//                    Text("経度" + String(longitude))
//                }
//            }
            HStack {
                if let prefecture = contentVM.cityData?.response.location[0].prefecture {
                    Text(prefecture)
                }
                if let city = contentVM.cityData?.response.location[0].city {
                    Text(city)
                }
                if let town = contentVM.cityData?.response.location[0].town {
                    Text(town)
                }
            }
            if let weatherData = contentVM.weatherData {
                ChartView(weatherData: weatherData)
                    .padding()
            } else {
                Spacer()
            }
        }
        .loading(isRefleshing: contentVM.shouldShowIndicator)
        .onAppear {
            contentVM.fetchWeatherData()
        }
        .onChange(of: locationManager.location) { _ in
            contentVM.fetchWeatherData()
            contentVM.fetchCityData()
        }
        .alert(isPresented: $contentVM.shouldShowAlert, error: contentVM.error) { _ in
            Button("OK", action: {})
        } message: { error in
            Text(error.errorDescription ?? "nil")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
