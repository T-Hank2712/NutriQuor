//
//  IngredientCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

enum IngredientStatus {
    case safe, moderate, caution

    var color: Color {
        switch self {
        case .safe:     return Color("SuccessTeal")
        case .moderate: return Color("WarningAmber")
        case .caution:  return Color("AccentOrange")
        }
    }

    var backgroundColor: Color {
        color.opacity(0.12)
    }

    var borderColor: Color {
        color.opacity(0.18)
    }

    var label: String {
        switch self {
        case .safe:     return "Thành phần"
        case .moderate: return "Cần lưu ý"
        case .caution:  return "Phụ gia"
        }
    }

    var icon: String {
        switch self {
        case .safe: return "checkmark.circle.fill"
        case .moderate: return "info.circle.fill"
        case .caution: return "exclamationmark.triangle.fill"
        }
    }
}

struct IngredientCard: View {
    var title: String
    var index: Int? = nil
    var status: IngredientStatus

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(status.backgroundColor)
                    .frame(width: 38, height: 38)

                if let index {
                    Text("\(index)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(status.color)
                } else {
                    Image(systemName: status.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(status.color)
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 5) {
                    Image(systemName: status.icon)
                        .font(.system(size: 10, weight: .bold))

                    Text(status.label)
                        .font(.system(size: 11, weight: .bold))
                        .lineLimit(1)
                }
                .foregroundStyle(status.color)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.secondary.opacity(0.45))
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 66, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        )
        .overlay(
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(status.color)
                    .frame(width: 3)
                Spacer()
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(status.borderColor, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    VStack(spacing: 12) {
        IngredientCard(
            title: "Spring Water",
            index: 1,
            status: .safe
        )
        IngredientCard(
            title: "Citric Acid",
            index: 2,
            status: .moderate
        )
        IngredientCard(
            title: "Sodium Benzoate",
            index: 3,
            status: .caution
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
