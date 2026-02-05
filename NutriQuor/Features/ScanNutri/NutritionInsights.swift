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
    let ocrData: OCRData?
    let onDismiss: () -> Void
    @State private var selectedRow: NutriText?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - History Summary
                HistoryItem(record: nutriItem)

                // MARK: - Nutrition Section
                VStack(alignment: .leading, spacing: 16) {
                    let data = ocrData
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

                    // Hiển thị từng hàng OCR
                    if let data = ocrData, !data.rows.isEmpty {
                        VStack(spacing: 0) {
                            ForEach(data.rows) { row in
                                NutriRowItem(record: NutriText(text: row.text))
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedRow = NutriText(text: row.text)
                                    }
                            }
                            .sheet(item: $selectedRow) { row in
                                VStack(spacing: 16) {
                                    Text("Chi tiết")
                                        .font(.headline)

                                    Text(row.text)

                                    Button("Đóng") {
                                        selectedRow = nil
                                    }
                                }
                                .padding()
                            }

                        }
                    } else {
                        Text("Không có dữ liệu dinh dưỡng")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
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
                        ),
                      ocrData: OCRData(
                          fullText: "Năng lượng/ Energy 94 kcal\nChất béo/ Fat 1.3 g\nProtein 1.4 g",
                          rows: [
                              OCRRow(rowNumber: 1, text: "Năng lượng/ Energy 94 (5%) kcal", items: nil),
                              OCRRow(rowNumber: 2, text: "Chất béo/ Fat 1.3 (2%) g", items: nil),
                              OCRRow(rowNumber: 3, text: "Chất đạm/ Protein 1.4 (3%) g", items: nil)
                          ],
                          nutritionInfo: [
                              "energy": "Năng lượng/ Energy 94 (5%) kcal",
                              "fat": "Chất béo/ Fat 1.3 (2%) g",
                              "protein": "Chất đạm/ Protein 1.4 (3%) g"
                          ]
                      ),
                      onDismiss: {}
    )
}
