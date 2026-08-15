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
            ScanHistoryThumbnail(
                imageUrl: record.imageUrl,
                size: 58
            )

            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(record.productName ?? "Sản phẩm chưa đặt tên")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                HStack(spacing: 5) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(Color("WarningAmber"))
                    Text(record.warning ?? "Không có cảnh báo")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                }

                Text(
                    (record.createdAt ?? Date()).formatted(
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
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(Color.primary.opacity(0.06), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.03), radius: 8, y: 3)
        )
    }
}

#Preview {
    HomeHistoryItem(
        record: ScanHistory(
            analysisId: "analysis-1",
            productName: "Nestlé Milo",
            warning: "Có chứa sữa",
            createdAt: Date()
        )
    )
}
