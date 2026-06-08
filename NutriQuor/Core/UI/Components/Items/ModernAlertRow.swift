//
//  ModernAlertRow.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import SwiftUI

struct ModernAlertRow: View {
    let icon: String
    let color: Color
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(0.1))
                    .frame(width: 38, height: 38)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
                Text(description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(color.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(color.opacity(0.15), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ModernAlertRow(
        icon: "exclamationmark.triangle.fill",
        color: Color("WarningAmber"),
        title: "Cảnh báo",
        description: "Không dành cho trẻ em dưới 3 tuổi."
    )
}
