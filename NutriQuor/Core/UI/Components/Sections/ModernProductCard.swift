//
//  ModernProductCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct ModernProductCard: View {
    let name: String
    let tags: [String]

    var body: some View {
        HStack(spacing: 14) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("ColorPrimary").opacity(0.1))
                    .frame(width: 46, height: 46)

                Image(systemName: "leaf.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color("ColorPrimary"))
            }

            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                if !tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(tags.prefix(2), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color("AccentPinkLight"))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(
                                    Capsule()
                                        .fill(Color("ColorPrimary").opacity(0.12))
                                )
                        }
                    }
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        ModernProductCard(name: "Aspartame", tags: ["E951", "Chất tạo ngọt"])
        ModernProductCard(name: "Vitamin C", tags: [])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
