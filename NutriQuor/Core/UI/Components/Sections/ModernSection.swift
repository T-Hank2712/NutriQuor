//
//  ModernSection.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct ModernSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color("ColorPrimary"))
                Text(title)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondary)
                    .kerning(1.2)
            }

            BentoCard(accent: Color("ColorPrimary"), style: .plain, padding: 16) {
                VStack(spacing: 0) {
                    content
                }
                .padding(.vertical, 2)
            }
        }
    }
}

#Preview {
    ModernSection(title: "TÀI KHOẢN", icon: "person.crop.circle") {
        ModernOptionRow(
            title: "Chỉnh sửa hồ sơ",
            subtitle: "Tên, ảnh đại diện, thông tin cá nhân",
            icon: "person.text.rectangle.fill",
            iconColor: Color("AccentPink")
        )
        Divider().padding(.leading, 56)
        ModernOptionRow(
            title: "Đổi mật khẩu",
            subtitle: "Cập nhật mật khẩu bảo mật",
            icon: "lock.fill",
            iconColor: Color("DeepNavy")
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
