//
//  HomeHistoryItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct HomeHistoryItem: View {
    let record: ScanHistory

//    private var scoreColor: Color {
//        switch record.score.lowercased() {
//        case "tốt": return Color("SuccessTeal")
//        case "xấu": return Color("AccentPink")
//        default:    return Color("ColorPrimary")
//        }
//    }
//
//    private var scoreIcon: String {
//        switch record.score.lowercased() {
//        case "tốt": return "checkmark.circle.fill"
//        case "xấu": return "xmark.circle.fill"
//        default:    return "minus.circle.fill"
//        }
//    }

    var body: some View {
        HStack(spacing: 14) {
            // Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color("ColorPrimary").opacity(0.12))
                    .frame(width: 58, height: 58)

                Image("Example")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 58, height: 58)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }

            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(record.product.productName ?? "")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                HStack(spacing: 5) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(Color("ColorPrimary"))
                    Text(record.product.warning ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                }

                Text(
                    record.scannedAt.formatted(
                        date: .omitted,
                        time: .shortened
                    )
                )
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
            }

            Spacer()

            // Score badge
//            VStack(spacing: 4) {
//                Image(systemName: scoreIcon)
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundStyle(scoreColor)
//
//                Text(record.score)
//                    .font(.system(size: 11, weight: .bold, design: .rounded))
//                    .foregroundStyle(scoreColor)
//            }
//            .padding(.trailing, 4)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
        )
    }
}

#Preview {
    HomeHistoryItem(
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

