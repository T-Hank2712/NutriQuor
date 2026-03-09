//
//  MonthSplineChart.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI
import Charts
struct MonthSplineChart: View {
    
    var body: some View {
        
        Chart(monthData) { item in
            
            LineMark(
                x: .value("Day", item.date),
                y: .value("Value", item.value)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            .foregroundStyle(.green)
            
            AreaMark(
                x: .value("Day", item.date),
                y: .value("Value", item.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(
                LinearGradient(
                    colors: [.green.opacity(0.3), .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .frame(height: 220)
        
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 6)) { value in
                AxisValueLabel(format: .dateTime.day())
            }
        }
        
        .chartYAxis {
            AxisMarks()
        }
        
        .padding()
    }
}
let monthData: [MonthData] = (1...30).map { day in
    MonthData(
        date: Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: day))!,
        value: Double.random(in: 50...200)
    )
}

#Preview {
    MonthSplineChart()
}
