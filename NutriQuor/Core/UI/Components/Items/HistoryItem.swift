//
//  HistoryItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import SwiftUI

struct HistoryItem: View {
    let record: ProductDTO
    
    var body: some View {
        HStack {
            Image("Example")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.productName)
                    .font(.subheadline)
                    .lineLimit(1)
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow).opacity(.opacityStrong)
                    Text(record.warning ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                HStack {
                    Image(systemName: "circle.fill").foregroundColor(.orange).opacity(.opacityStrong)
                    Text(record.createdAt ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()

        }
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color(.colorPrimary).opacity(.opacityMedium), lineWidth: 1.5)
        )
    }
}

#Preview {
    HistoryItem(
        record: ProductDTO(
            id: 1,
            userId: 1,
            productName: "Bánh quy ABC",
            ageRange: "3+",
            ingredients: [
                "Bột mì",
                "Đường",
                "Dầu thực vật"
            ],
            additive: [
                "INS 322",
                "INS 500(ii)"
            ],
            nutrition: ProductDTO.Nutrition(
                energy: "450 kcal",
                protein: "6 g",
                fat: "18 g",
                sugar: "22 g"
            ),
            manufacturer: "ABC Food",
            mfgDate: "2026-01-01",
            expiryDate: "2027-01-01",
            netWeight: "200 g",
            allergen: "Gluten",
            warning: "Nhiều đường",
            origin: "Việt Nam",
            createdAt: "2026-06-09T05:27:07.241790Z",
            timeZone: "Asia/Ho_Chi_Minh",
            createdAtLocal: Date()
        )
    )
}
