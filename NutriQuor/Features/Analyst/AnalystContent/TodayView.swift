//
//  TodayView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                // MARK: - Scores
                HealthScoreRing(title: "HEALTH SCORE",score: 70, size: 220, lineWidth: 16)
                
                HStack{
                    NutrientRing(percent: 70, color: .orange, label: "Protein", value: "70%")
                    NutrientRing(percent: 30, color: .blue, label: "Fat", value: "30%")
                    NutrientRing(percent: 10, color: .pink, label: "Sugar", value: "10%")
                }
                
                // MARK: - Limit
                VStack(alignment: .leading, spacing: 20){
                    Text("Limit")
                        .font(.title2).bold()
                    LitmitBar(title: "Fats", value: 75, limit: 150 , unit: "g", color: .orange)
                    LitmitBar(title: "Sugar", value: 10, limit: 50, unit: "g", color: .yellow)
                    LitmitBar(title: "Carbs", value: 100, limit: 600, unit: "g", color: .blue)
                }
                
                // MARK: - Best and worst day
                HStack(spacing: 10){
                    SummaryCard(title: "Best Day",
                                icon: "star.fill",
                                day: "20/6",
                                date: "Today",
                                value: 1500,
                                color: .green)
                    
                    SummaryCard(title: "Worst Day",
                                icon: "exclamationmark.triangle.fill",
                                day: "17/6",
                                date: "3 days ago",
                                value: 600,
                                color: .red)
                }
                
                // MARK: - History
                Text("Today")
                    .font(.title2).bold()
                HistoryItem(record: History(
                    image: Image("Example"),
                    title: "Bánh quy ABC",
                    warning: "Nhiều đường",
                    score: "Xấu",
                    time: Calendar.current.date(
                        from: DateComponents(
                            year: 2025,
                            month: 1,
                            day: 24,
                            hour: 21,
                            minute: 04
                        )
                    )!
                ))
            }.padding(.vertical, 20)
        }
    }
}

#Preview {
    TodayView()
}
