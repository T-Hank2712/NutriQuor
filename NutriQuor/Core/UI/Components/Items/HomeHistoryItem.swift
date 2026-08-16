//
//  HomeHistoryItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct HomeHistoryItem: View {
    let record: ScanHistory

    var body: some View {
        HStack(spacing: 14) {
            ScanHistoryThumbnail(
                imageRef: record.imageRef,
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

                Text(displayTime)
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
            }

            Spacer()

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

    private var displayTime: String {
        guard let createdAt = record.createdAt else {
            return "Chưa rõ thời gian"
        }

        return createdAt.formatted(
            date: .omitted,
            time: .shortened
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
