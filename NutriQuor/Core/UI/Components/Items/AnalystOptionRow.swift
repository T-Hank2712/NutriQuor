//
//  AnalystOptionRow.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import SwiftUI

struct AnalystOptionRow: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        Button {
            print(title)
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.12))
                        .frame(width: 36, height: 36)
                    Image(systemName: icon)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(color)
                }
                Text(title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.tertiary)
            }
            .padding(.vertical, 6)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AnalystOptionRow(
        title: "Chia sẻ sản phẩm",
        icon: "square.and.arrow.up.fill",
        color: Color("AccentPurple")
    )
}
