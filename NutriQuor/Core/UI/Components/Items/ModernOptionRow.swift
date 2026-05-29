//
//  ModernOptionRow.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct ModernOptionRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(iconColor)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ModernOptionRow(
        title: "Chỉnh sửa hồ sơ",
        subtitle: "Tên, ảnh đại diện, thông tin cá nhân",
        icon: "person.text.rectangle.fill",
        iconColor: Color("AccentPink")
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
