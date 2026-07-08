//
//  IngredientSection.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct IngredientSection: View {
    let title: String
    let tag: String
    let ingredients: [String]?

    private var status: IngredientStatus {
        isAdditiveSection ? .caution : .safe
    }

    private var isAdditiveSection: Bool {
        let normalizedTitle = title.lowercased()
        return normalizedTitle.contains("additive") || normalizedTitle.contains("phụ")
    }

    private var icon: String {
        isAdditiveSection ? "testtube.2" : "leaf.fill"
    }

    private var subtitle: String {
        isAdditiveSection ? "Các phụ gia được trích xuất từ nhãn" : "Các nguyên liệu chính trong sản phẩm"
    }

    private var items: [String] {
        ingredients ?? []
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack(alignment: .center, spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(status.color)
                    .frame(width: 34, height: 34)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(status.backgroundColor)
                    )

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                Spacer(minLength: 0)
            }

            if items.isEmpty {
                EmptyIngredientRow(status: status)
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        IngredientCard(
                            title: item,
                            index: index + 1,
                            status: status
                        )
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.primary.opacity(0.06), lineWidth: 1)
        )
    }
}

private struct EmptyIngredientRow: View {
    let status: IngredientStatus

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "tray.fill")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(status.color)
                .frame(width: 34, height: 34)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(status.backgroundColor)
                )

            VStack(alignment: .leading, spacing: 3) {
                Text("Chưa có dữ liệu")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary)

                Text("API chưa trả về mục nào cho nhóm này")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            IngredientSection(
                title: "Thành phần",
                tag: "3 mục",
                ingredients: [
                    "Spring Water",
                    "Citric Acid",
                    "Sodium Benzoate"
                ]
            )

            IngredientSection(
                title: "Phụ gia",
                tag: "0 mục",
                ingredients: []
            )
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
