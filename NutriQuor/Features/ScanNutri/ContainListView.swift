//
//  ContainList.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct ContainListView: View {
    let ingredients: [String]
    let additives: [String]
    let ingredientItems: [ProductIngredient]
    let additiveItems: [ProductAdditive]

    init(
        ingredients: [String],
        additives: [String],
        ingredientItems: [ProductIngredient] = [],
        additiveItems: [ProductAdditive] = []
    ) {
        self.ingredients = ingredients
        self.additives = additives
        self.ingredientItems = ingredientItems
        self.additiveItems = additiveItems
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                ContainListHeader()

                IngredientSection(
                    title: "Thành phần",
                    tag: "\(ingredientNames.count) mục",
                    ingredients: ingredientNames,
                    detailIDs: ingredientDetailIDs
                )

                IngredientSection(
                    title: "Phụ gia",
                    tag: "\(additiveNames.count) mục",
                    ingredients: additiveNames,
                    detailIDs: additiveDetailIDs
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 18)
            .padding(.bottom, 28)
        }
        .background(Color("Background"))
        .navigationTitle("Chi tiết thành phần")
        .navigationBarTitleDisplayMode(.inline)
        .hideBottomBarOnDetail()
    }

    private var additiveNames: [String] {
        additiveItems.isEmpty ? additives : additiveItems.map(\.displayName)
    }

    private var ingredientNames: [String] {
        ingredientItems.isEmpty ? ingredients : ingredientItems.map(\.displayName)
    }

    private var ingredientDetailIDs: [String?] {
        ingredientItems.isEmpty ? [] : ingredientItems.map(\.id)
    }

    private var additiveDetailIDs: [String?] {
        additiveItems.isEmpty ? [] : additiveItems.map(\.id)
    }
}

private struct ContainListHeader: View {
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color("ColorPrimary").opacity(0.12))
                    .frame(width: 48, height: 48)

                Image(systemName: "list.bullet.clipboard.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(Color("ColorPrimary"))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Bảng thành phần")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)

                Text("Danh sách được trích xuất từ nhãn sản phẩm")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
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

#Preview {
    ContainListView(
        ingredients: [
            "Spring Water",
            "Citric Acid",
            "Sodium Benzoate"
        ],
        additives: [
            "E202",
            "E330",
            "E211"
        ]
    )
}
