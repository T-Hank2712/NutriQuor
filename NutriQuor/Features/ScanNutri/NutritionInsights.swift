//
//  NutritionInsights.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//
import SwiftUI

struct NutritionInsights: View {
    let nutriItem: History
    let nutrition: Nutrition

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - History Summary
                HistoryItem(record: nutriItem)

                // MARK: - Nutrition Section
                VStack(alignment: .leading, spacing: 16) {

                    HStack {
                        Text("Nutrition Analysis")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color(.primary))

                        Spacer()

                        Image(systemName: "chart.bar.fill")
                            .foregroundColor(.green)
                    }

                    Divider()

                    // Có thể đổi thành danh sách thật sau
                    ForEach(0..<5) { _ in
                        NutriRowItem(record: nutrition)
                    }

                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
                )
                
                InsightCard(title: "Warning", detail: "Không dùng cho trẻ em dưới 2 tuổi", color: .orange)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Options")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color(.primary))
                    OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.primary))
                    OptionCard(title: "Chia sẻ", icon: "square.and.arrow.up", color: Color(.primary))
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    NutritionInsights(nutriItem: History(
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
        ),
                      nutrition: Nutrition(
                        name: "Calories",
                        unit: "kcal",
                        value: 100.0
                        )
    )
}
