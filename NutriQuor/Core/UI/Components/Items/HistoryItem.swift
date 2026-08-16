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
            ScanHistoryThumbnail(
                imageRef: record.imageRef,
                imageUrl: record.imageUrl,
                size: 64
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.productName ?? "Sản phẩm chưa đặt tên")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color("WarningAmber"))
                    Text(record.warning ?? "Không có cảnh báo")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(Color("ColorPrimary"))
                    Text(displayTime)
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
    HistoryItem(
        record: ScanHistory(
            analysisId: "analysis-1",
            productName: "Nestlé Milo",
            warning: "Có chứa sữa",
            createdAt: Date()
        )
    )
}
