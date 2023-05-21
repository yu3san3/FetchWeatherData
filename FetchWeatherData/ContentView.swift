//
//  ContentView.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    
    var body: some View {
        VStack {
            if let latitude = contentVM.weatherData?.latitude {
                Text("緯度 " + String(latitude))
            }
            if let longitude = contentVM.weatherData?.longitude {
                Text("経度" + String(longitude))
            }
        }
        .onAppear {
            contentVM.fetchWeatherData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
