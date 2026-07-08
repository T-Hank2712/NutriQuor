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
        HStack(spacing: 14) {
            Image("Example")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: .cardRadius))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.product.productName ?? "")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color("WarningAmber"))
                    Text(record.product.warning ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(Color("ColorPrimary"))
                    Text(
                        record.scannedAt.formatted(
                            date: .omitted,
                            time: .shortened
                        )
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()

        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.primary.opacity(0.06), lineWidth: 1)
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
