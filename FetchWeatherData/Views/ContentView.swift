//
//  ContentView.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    
    @StateObject var manager = LocationManager()
    
    var body: some View {
        VStack {
            HStack {
                Text("\(manager.location.coordinate.latitude)")
                Text("\(manager.location.coordinate.longitude)")
            }
            HStack {
                if let latitude = contentVM.weatherData?.latitude {
                    Text("緯度 " + String(latitude) + ",")
                }
                if let longitude = contentVM.weatherData?.longitude {
                    Text("経度" + String(longitude))
                }
            }
            if let weatherData = contentVM.weatherData {
                ChartView(weatherData: weatherData)
                    .padding()
            }
        }
        .loading(isRefleshing: contentVM.shouldShowIndicator)
        .onAppear {
            contentVM.fetchWeatherData()
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
