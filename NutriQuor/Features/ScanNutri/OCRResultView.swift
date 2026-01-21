//
//  OCRResultView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/1/26.
//

import SwiftUI

struct OCRResultView: View {
    let ocrData: OCRData?
    let onDismiss: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let data = ocrData {
                        // Text đầy đủ
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Văn bản nhận diện")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(data.fullText)
                                .font(.body)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                        }
                        
                        // Hiển thị từng row
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Chi tiết từng dòng")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            ForEach(data.rows) { row in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Dòng \(row.rowNumber)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text(row.text)
                                        .font(.body)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.05))
                                .cornerRadius(8)
                            }
                        }
                        
                        // Thông tin dinh dưỡng đã parse
                        if !data.nutritionInfo.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Thông tin dinh dưỡng")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                ForEach(Array(data.nutritionInfo.keys.sorted()), id: \.self) { key in
                                    if let value = data.nutritionInfo[key] {
                                        NutritionInfoRow(label: key.capitalized, value: value)
                                    }
                                }
                            }
                        }
                        
                        // Nút xác nhận
                        Button {
                            onDismiss()
                        } label: {
                            Text("Hoàn tất")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(12)
                        }
                        .padding(.top, 20)
                        
                    } else {
                        Text("Không có dữ liệu")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            .navigationTitle("Kết quả phân tích")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NutritionInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
    }
}

#Preview {
    OCRResultView(
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
