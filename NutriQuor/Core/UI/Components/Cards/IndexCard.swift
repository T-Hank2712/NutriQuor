//
//  IndexCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct IndexCard: View {
    let latestScan: ScanHistory?

    var body: some View {
        BentoCard(accent: Color("ColorPrimary"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    if let latestScan {
                        ScanHistoryThumbnail(
                            imageRef: latestScan.imageRef,
                            imageUrl: latestScan.imageUrl,
                            size: 42
                        )
                    } else {
                        Image(systemName: "clock.badge.questionmark.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color("ColorPrimary"))
                            .frame(width: 42, height: 42)
                            .background(
                                RoundedRectangle(cornerRadius: .cardRadius)
                                    .fill(Color("ColorPrimary").opacity(0.10))
                            )
                    }

                    Spacer()
                }
                   
                Text("LẦN QUÉT GẦN NHẤT")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                if let latestScan {
                    Text(latestScan.productName ?? "Sản phẩm chưa đặt tên")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("Heading"))
                        .lineLimit(2)

                    if let createdAt = latestScan.createdAt {
                        Text(createdAt.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Text("Chưa có dữ liệu hôm nay")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("Heading"))
                        .lineLimit(2)

                    Text("Quét nhãn đầu tiên để bắt đầu theo dõi.")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 144, maxHeight: 144, alignment: .leading)
        }
    }
}

#Preview {
    IndexCard(
        latestScan: ScanHistory(
            analysisId: "analysis-1",
            productName: "Sữa hạt",
            imageUrl: nil,
            createdAt: Date()
        )
    )
}
