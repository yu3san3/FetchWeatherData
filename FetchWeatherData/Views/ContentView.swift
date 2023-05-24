//
//  ContentView.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//
//  2023/05/25 Alpha 1.0.0(1)

import SwiftUI

//バージョン情報
let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//ビルド情報
let appBuildNum = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    @StateObject var locationManager = LocationManager()
    
    @State private var shouldShowAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack(spacing: 7) {
                ZStack {
                    VStack {
                        Text(contentVM.prefectureAndCityName)
                            .font(.title)
                            .bold()
                        Text(contentVM.cityKana)
                    }
                    HStack() {
                        Spacer()
                        Button(action: {
                            shouldShowAlert = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .alert(
                            "Version \(appVersion)(\(appBuildNum))",
                               isPresented: $shouldShowAlert
                        ) {
                            Button("OK") {}
                        }
                    }
                }
                HStack {
                    Text("緯度 \(locationManager.location.coordinate.latitude)")
                    Text("経度 \(locationManager.location.coordinate.longitude)")
                }
            }
            .padding()
            Group {
                if let weatherData = contentVM.weatherData {
                    ChartView(weatherData: weatherData)
                        .padding(.horizontal)
                } else {
                    Spacer()
                }
            }
        }
        .loading(isRefleshing: contentVM.shouldShowIndicator)
        .task(id: locationManager.location) {
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
