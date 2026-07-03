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
        case .safe:     return Color(red: 0.13, green: 0.77, blue: 0.37)
        case .moderate: return Color(red: 0.96, green: 0.62, blue: 0.04)
        case .caution:  return Color(red: 0.94, green: 0.27, blue: 0.27)
        }
    }

    var backgroundColor: Color {
        switch self {
        case .safe:     return Color(red: 0.86, green: 0.99, blue: 0.90)
        case .moderate: return Color(red: 0.99, green: 0.95, blue: 0.78)
        case .caution:  return Color(red: 0.99, green: 0.89, blue: 0.89)
        }
    }

    var label: String {
        switch self {
        case .safe:     return "Safe"
        case .moderate: return "Moderate"
        case .caution:  return "Caution"
        }
    }
}

struct IngredientCard: View {
    var title: String
    var status: IngredientStatus

    var body: some View {
        HStack(alignment: .top, spacing: 14) {

            // Dot icon with soft background circle
            ZStack {
                Circle()
                    .fill(status.backgroundColor)
                    .frame(width: 15, height: 15)
                Circle()
                    .fill(status.color)
                    .frame(width: 5, height: 5)
            }
            .padding(.top, 2)

            // Text content
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            // Status badge
            Text(status.label)
                .font(.system(size: 11, weight: .medium))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(status.backgroundColor)
                .foregroundColor(status.color.opacity(0.85))
                .clipShape(Capsule())
                .padding(.top, 2)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray.opacity(0.12), lineWidth: 0.5)
        )
        .overlay(
            // Left accent bar
            HStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(status.color)
                    .frame(width: 3)
                Spacer()
            }
        )
    }
}

#Preview {
    VStack(spacing: 12) {
        IngredientCard(
            title: "Spring Water",
            status: .safe
        )
        IngredientCard(
            title: "Citric Acid",
            status: .moderate
        )
        IngredientCard(
            title: "Sodium Benzoate",
            status: .caution
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
