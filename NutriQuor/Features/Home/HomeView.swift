//
//  HomeView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct HomeView: View {
    let items: [History] = [
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(year: 2025, month: 1, day: 24, hour: 21, minute: 04)
            )!
        ),
        History(
            image: Image("Example"),
            title: "Sữa tươi XYZ",
            warning: "Ít đường",
            score: "Tốt",
            time: Calendar.current.date(
                from: DateComponents(year: 2025, month: 1, day: 24, hour: 18, minute: 15)
            )!
        )
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // HEADER
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Xin chào,")
                            .foregroundColor(.secondary)
                        Text("Thành Lâm")
                            .fontWeight(.semibold)
                    }

                    Spacer()

                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                }
                
                HealthScoreCard()

                // TITLE + FILTER
                HStack {
                    Text("Indexes")
                        .font(.title)
                        .fontWeight(.bold)
                }

                // STATS GRID
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ],
                    spacing: 16
                ) {
                    StatCard(nutri: Nutrition(name: "Calories", unit: "kcal", value: 50.0), icon: "flame", iconColor: .red)
                    StatCard(nutri: Nutrition(name: "Proteins", unit: "kcal", value: 50.0), icon: "bolt.fill", iconColor: .blue)
                    StatCard(nutri: Nutrition(name: "Sugars", unit: "kcal", value: 50.0), icon: "birthday.cake.fill", iconColor: .orange)
                    StatCard(nutri: Nutrition(name: "Fats", unit: "kcal", value: 50.0), icon: "atom", iconColor: .yellow)
                }
                
                HStack {
                    Text("Scans")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ForEach(items) { item in
                    HistoryItem(record: item)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

