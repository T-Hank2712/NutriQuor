//
//  WeekView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI
import Charts
struct WeekView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                HealthScoreRing(title: "HEALTH SCORE",score: 70, size: 220, lineWidth: 16)
                Tag(text: "5% better than last week", color: Color.green)
                
                
                // MARK: - Chart
                VStack(alignment: .leading){
                    Text("Daily Performance").frame(maxWidth: .infinity, alignment: .leading).font(.title2).bold()
                    WeekChart()
                }

                
                // MARK: - Limit
                VStack(alignment: .leading, spacing: 20){
                    Text("Weekly Limit")
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
            }.padding(.vertical, 20)
        }
    }
}

#Preview {
    WeekView()
}
