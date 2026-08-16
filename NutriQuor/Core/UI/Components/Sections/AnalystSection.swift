//
//  AnalystSection.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import SwiftUI

struct AnalystSection<Content: View>: View {
    let title: String
    let icon: String
    let iconColor: Color
    @ViewBuilder let content: Content

    var body: some View {
        BentoCard(accent: iconColor, style: .plain, padding: 18) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(iconColor.opacity(0.12))
                            .frame(width: 30, height: 30)
                        Image(systemName: icon)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(iconColor)
                    }
                    Text(title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                }
                content
            }
        }
    }
}

#Preview {
    AnalystSection(title: "Dinh dưỡng", icon: "chart.bar.fill", iconColor: Color("ColorPrimary")) {
        Text("Thông tin dinh dưỡng được hiển thị từ dữ liệu phân tích nhãn.")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
