//
//  WeekChart.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI
import Charts
struct WeekChart: View {
    
    var body: some View {
        Chart(weekData) { item in
                    
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Value", item.value)
                    )
                    .foregroundStyle(.green)
                    .cornerRadius(6)
                }
                .frame(height: 200)
    }
}
let weekData: [ChartData] = [
    .init(day: "Mon", value: 80),
    .init(day: "Tue", value: 120),
    .init(day: "Wed", value: 160),
    .init(day: "Thu", value: 60),
    .init(day: "Fri", value: 130),
    .init(day: "Sat", value: 150),
    .init(day: "Sun", value: 100)
]
#Preview {
    WeekChart()
}
