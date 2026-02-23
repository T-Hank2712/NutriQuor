//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct AnalystView: View {
    enum FilterType: String, CaseIterable {
        case today = "Today"
        case sevenDays = "7 Days"
        case thirtyDays = "30 Days"
    }
    
    @State private var selectedFilter: FilterType = .today
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Phân tích")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // FILTER
                HStack(spacing: 8) {
                    ForEach(FilterType.allCases, id: \.self) { filter in
                        Button {
                            selectedFilter = filter
                        } label: {
                            Text(filter.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(selectedFilter == filter ? .white : .gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedFilter == filter ? Color(.primary) : Color.gray.opacity(0.15))
                                )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .stroke(Color(.primary).opacity(0.4), lineWidth: 0.5)
                )
                
                // TODAY STAT
                VStack(spacing: 16) {
                    Text("Today Statistics")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 20) {
                        StatCircle(title: "Calories",
                                   value: "500/1000",
                                   color: .orange)
                        
                        StatCircle(title: "Proteins",
                                   value: "10/100",
                                   color: .blue)
                        
                        StatCircle(title: "Fats",
                                   value: "10/100",
                                   color: .yellow)
                        
                        StatCircle(title: "Sugar",
                                   value: "500/1000",
                                   color: .purple)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray6))
                )
                
                // CHART
                VStack(spacing: 16) {
                    
                    Text("Calories")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack(alignment: .bottom, spacing: 12) {
                        ForEach(sampleData, id: \.day) { item in
                            VStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.orange)
                                    .frame(width: 35,
                                           height: item.value)
                                
                                Text(item.day)
                                    .font(.caption)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray6))
                )
                
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}
struct ChartData {
    let day: String
    let value: CGFloat
}

let sampleData: [ChartData] = [
    .init(day: "14/6", value: 80),
    .init(day: "15/6", value: 120),
    .init(day: "16/6", value: 160),
    .init(day: "17/6", value: 60),
    .init(day: "18/6", value: 130),
    .init(day: "19/6", value: 150),
    .init(day: "20/6", value: 100)
]
#Preview {
    AnalystView()
}
