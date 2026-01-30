//
//  HomeView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct HomeView: View {
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

                // TITLE + FILTER
                HStack {
                    Text("Indexes")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    FilterButton(title: "Today")
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

                // PEDOMETER
                HStack {
                    Text("Pedometer")
                        .font(.title2)
                        .fontWeight(.bold)

                    Spacer()
                    FilterButton(title: "Past Week")
                }

                BarChartView()
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}


// MARK: - Bar Chart
struct BarChartView: View {
    let data: [CGFloat] = [1500, 2100, 1500, 1000, 1700, 2300, 1500]
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(data.indices, id: \.self) { index in
                VStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(index == 5 ? Color.blue : Color.blue.opacity(0.2))
                        .frame(height: data[index] / 8)

                    Text(days[index])
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.top, 16)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

