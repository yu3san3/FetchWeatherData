//
//  ChartView.swift
//  FetchWeatherData
//
//  Created by 丹羽雄一朗 on 2023/05/22.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let temperatureData: [ChartData]
    
    var body: some View {
        Chart {
            ForEach(temperatureData, id: \.chartName) { temperature in
                ForEach(temperature.data) {
                    LineMark (
                        x: .value("date", $0.date),
                        y: .value("temperature", $0.temperature)
                    )
                }
                .foregroundStyle(by: .value("chartType", temperature.chartName))
            }
        }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView(temperatureData: )
//    }
//}
