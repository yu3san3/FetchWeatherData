//
//  ChartView.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/22.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @StateObject var chartVM = ChartViewModel()
    
    let weatherData: WeatherData
    
    var body: some View {
        Chart {
            ForEach(chartVM.chartData, id: \.name) { chartData in
                ForEach(chartData.data) {
                    let parts = $0.date.split(separator: "-")
                    LineMark (
                        x: .value("Date", parts[1] + "/" + parts[2]),
                        y: .value("Temperature", $0.temperature)
                    )
                }
                .foregroundStyle(by: .value("Name", chartData.name))
                .symbol(by: .value("Name", chartData.name))
            }
        }
        .task(id: [weatherData.latitude, weatherData.longitude]) {
            withAnimation {
                chartVM.generateChartData(weatherData: weatherData)
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(weatherData: mockWeatherData)
    }
}
