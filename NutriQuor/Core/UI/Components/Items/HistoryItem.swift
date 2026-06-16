//
//  HistoryItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import SwiftUI

struct HistoryItem: View {
    let record: ScanHistory
    
    var body: some View {
        HStack {
            Image("Example")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.product.productName ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow).opacity(.opacityStrong)
                    Text(record.product.warning ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                HStack {
                    Image(systemName: "circle.fill").foregroundColor(.orange).opacity(.opacityStrong)
                    Text(
                        record.scannedAt.formatted(
                            date: .omitted,
                            time: .shortened
                        )
                    )
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
        record: ScanHistory(
            id: UUID(),
            scannedAt: Date(),
            product: Product(
                productName: "Nestlé Milo",
                ageRange: "4+",
                ingredients: [
                    "Milk powder",
                    "Cocoa powder"
                ],
                additive: [
                    "INS 322"
                ],
                nutrition: [
                    "energy": "420 kcal",
                    "protein": "14 g"
                ],
                manufacturer: "Nestlé Vietnam",
                mfgDate: "2026-01-15",
                expiryDate: "2027-01-15",
                netWeight: "400g",
                allergen: "Contains milk",
                warning: "Store in a cool dry place",
                origin: "Vietnam"
            )
        )
    )
}
