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
    var description: String? = nil
    var type: String? = nil

    var body: some View {
        BentoCard(accent: cardColor, style: .plain, padding: 14) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .fill(cardColor.opacity(0.1))
                        .frame(width: 46, height: 46)

                    Image(systemName: cardIcon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(cardColor)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(name)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    if let description, !description.isEmpty {
                        Text(description)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }

                    if !tags.isEmpty {
                        HStack(spacing: 6) {
                            ForEach(tags.prefix(2), id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundStyle(cardColor)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(
                                        Capsule()
                                            .fill(cardColor.opacity(0.10))
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
        }
    }

    private var cardIcon: String {
        switch type {
        case "ingredient": return "leaf.fill"
        case "nutrient": return "chart.bar.fill"
        case "additive": return "plus.square.fill"
        default: return "sparkle.magnifyingglass"
        }
    }

    private var cardColor: Color {
        switch type {
        case "ingredient": return Color("SuccessTeal")
        case "nutrient": return Color("ColorPrimary")
        case "additive": return Color("AccentOrange")
        default: return Color("AccentPurple")
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ModernProductCard(name: "Aspartame", tags: ["E951", "Chất tạo ngọt"], description: "Phụ gia tạo ngọt thường gặp trong thực phẩm.", type: "additive")
        ModernProductCard(name: "Vitamin C", tags: [])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
