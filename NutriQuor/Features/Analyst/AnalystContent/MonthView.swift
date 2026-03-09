//
//  MonthView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct MonthView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                HealthScoreRing(title: "HEALTH SCORE",score: 50, size: 220, lineWidth: 16)
                Tag(text: "5% worse than last month", color: Color.orange)
                
                HStack{
                    Text("Health Trends").frame(maxWidth: .infinity, alignment: .leading).font(.title2).bold()
                    Spacer()
                    Text("March 2026").opacity(0.5).bold()
                }
                MonthSplineChart()
                
                HStack{
                    StatCard(nutri: Nutrition(name: "Carbs", unit: "g", value: 150.0), icon: "leaf.fill", iconColor: .green)
                    StatCard(nutri: Nutrition(name: "Calories", unit: "kcal", value: 50.0), icon: "flame.fill", iconColor: .red)
                }
                HStack{
                    StatCard(nutri: Nutrition(name: "Protein", unit: "kcal", value: 50.0), icon: "dumbbell.fill", iconColor: .blue)
                    StatCard(nutri: Nutrition(name: "Sugars", unit: "kcal", value: 50.0), icon: "drop.fill", iconColor: .yellow)
                }
            }.padding(.vertical, 20)
        }
    }
}

#Preview {
    MonthView()
}
