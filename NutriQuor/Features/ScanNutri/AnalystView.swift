//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//

import SwiftUI

struct AnalystView: View {
    let product: Product
    var showsDismissButton = false
    var onDismiss: () -> Void = { }

    @Environment(\.dismiss) private var dismiss
    @State private var showAllNutrition = false
    
    struct NutrientItem: Identifiable {
        let id: String
        let title: String
        let value: String?
        let color: Color
        let icon: String
        let detailID: String?
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 22) {

                // MARK: - Hero
                VStack(spacing: 18) {
                    ScanHistoryThumbnail(
                        imageRef: product.imageRef,
                        imageUrl: product.imageUrl,
                        size: 112
                    )
                    .padding(.top, 18)

                    VStack(spacing: 10) {
                        Text(product.productName ?? "Kết quả phân tích")
                            .font(.system(size: 26, weight: .black, design: .rounded))
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)

                        HStack(spacing: 8) {
                            ForEach(productTags, id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color("ColorPrimary"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 5)
                                    .background(
                                        Capsule()
                                            .fill(Color("ColorPrimary").opacity(0.15))
                                            .overlay(Capsule().stroke(Color("ColorPrimary").opacity(0.18), lineWidth: 1))
                                    )
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 12)

                // MARK: - Content
                VStack(spacing: 18) {

                    // MARK: - Nutrition
                    if !nutritionItems.isEmpty {
                        AnalystSection(title: "Dinh dưỡng",
                                       icon: "chart.bar.fill",
                                       iconColor: Color("ColorPrimary")) {

                            let displayItems = showAllNutrition ? nutritionItems : Array(nutritionItems.prefix(3))

                            VStack(spacing: 12) {
                                LazyVGrid(
                                    columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
                                    spacing: 12
                                ) {
                                    ForEach(displayItems) { item in
                                        if let detailID = item.detailID {
                                            FullScreenDetailLink {
                                                SearchDetailView(id: detailID)
                                            } label: {
                                                ModernNutrientCard(
                                                    title: item.title,
                                                    value: item.value ?? "0",
                                                    color: item.color,
                                                    icon: item.icon
                                                )
                                            }
                                        } else {
                                            ModernNutrientCard(
                                                title: item.title,
                                                value: item.value ?? "0",
                                                color: item.color,
                                                icon: item.icon
                                            )
                                        }
                                    }
                                }

                                if nutritionItems.count > 3 {
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                                            showAllNutrition.toggle()
                                        }
                                    } label: {
                                        Text(showAllNutrition ? "Thu gọn" : "Xem tất cả")
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundStyle(Color("ColorPrimary"))
                                    }
                                }
                            }
                        }
                    }
                    
                    // MARK: - Alerts
                    if let warning = product.warning, !warning.isEmpty {
                        AnalystSection(title: "Cảnh báo", icon: "exclamationmark.triangle.fill", iconColor: Color("WarningAmber")) {
                            VStack(spacing: 10) {
                                ModernAlertRow(
                                    icon: "exclamationmark.triangle.fill",
                                    color: Color("WarningAmber"),
                                    title: "Cảnh báo",
                                    description: warning
                                )
                            }
                        }
                    }

                    // MARK: - Contains
                    if hasContainData {
                        AnalystSection(title: "Thành phần", icon: "list.bullet.clipboard.fill", iconColor: Color("ColorPrimary")) {
                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    ModernContainCard(
                                        title: "Thành phần",
                                        good: "\(product.ingredients.count) mục",
                                        bad: "",
                                        goodColor: Color("SuccessTeal"),
                                        badColor: Color("ColorPrimary")
                                    )
                                    ModernContainCard(
                                        title: "Phụ gia",
                                        good: "\(product.additive.count) phụ gia",
                                        bad: "",
                                        goodColor: Color("ColorPrimary"),
                                        badColor: Color("ColorPrimary")
                                    )
                                }

                                FullScreenDetailLink {
                                    ContainListView(
                                        ingredients: product.ingredients,
                                        additives: product.additive,
                                        ingredientItems: product.ingredientItems,
                                        additiveItems: product.additiveItems
                                    )
                                } label: {
                                    HStack(spacing: 8) {
                                        Image(systemName: "ellipsis.circle.fill")
                                            .font(.system(size: 15))

                                        Text("Xem tất cả thành phần")
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    }
                                    .foregroundStyle(Color("ColorPrimary"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 13)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(Color("ColorPrimary").opacity(0.08))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(Color("ColorPrimary").opacity(0.25), lineWidth: 1.5)
                                            )
                                    )
                                }
                            }
                        }
                    }

                    if !detailRows.isEmpty {
                        AnalystSection(title: "Thông tin sản phẩm", icon: "info.circle.fill", iconColor: Color("InfoBlue")) {
                            VStack(spacing: 10) {
                                ForEach(detailRows, id: \.title) { row in
                                    ProductInfoRow(title: row.title, value: row.value)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(showsDismissButton)
        .toolbar {
            if showsDismissButton {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        onDismiss()
                        dismiss()
                    } label: {
                        ZStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .background(Color("Background"))
    }

    private var hasContainData: Bool {
        !product.ingredients.isEmpty || !product.additive.isEmpty
    }
    
    private var nutritionItems: [NutrientItem] {
        if !product.nutrientItems.isEmpty {
            return product.nutrientItems.map { item in
                let key = item.normalizedKey
                return NutrientItem(
                    id: item.stableID,
                    title: nutritionTitle(for: key, fallback: item.name),
                    value: item.displayValue,
                    color: nutritionColor(for: key),
                    icon: nutritionIcon(for: key),
                    detailID: item.id
                )
            }
        }

        return product.nutrition
            .sorted { $0.key < $1.key }
            .map { key, value in
            NutrientItem(
                id: key,
                title: nutritionTitle(for: key),
                value: value,
                color: nutritionColor(for: key),
                icon: nutritionIcon(for: key),
                detailID: nil
            )
        }
    }

    private var productTags: [String] {
        [
            product.netWeight,
            product.origin,
            product.ageRange
        ].compactMap { value in
            guard let value, !value.isEmpty else { return nil }
            return value
        }
    }

    private var detailRows: [(title: String, value: String)] {
        [
            ("Nhà sản xuất", product.manufacturer),
            ("Ngày sản xuất", product.mfgDate),
            ("Hạn sử dụng", product.expiryDate),
            ("Khối lượng", product.netWeight),
            ("Xuất xứ", product.origin)
        ].compactMap { title, value in
            guard let value, !value.isEmpty else { return nil }
            return (title, value)
        }
    }

    private func nutritionTitle(for key: String) -> String {
        nutritionTitle(for: key, fallback: nil)
    }

    private func nutritionTitle(for key: String, fallback: String?) -> String {
        switch key {
        case "energy": return "Năng lượng"
        case "protein": return "Protein"
        case "carbohydrate": return "Carb"
        case "sugars", "sugar": return "Đường"
        case "fat": return "Chất béo"
        case "saturated_fat", "saturatedFat": return "Béo bão hòa"
        case "sodium": return "Natri"
        default:
            if let fallback, !fallback.isEmpty {
                return fallback
            }

            return key
                .replacingOccurrences(of: "_", with: " ")
                .capitalized
        }
    }

    private func nutritionIcon(for key: String) -> String {
        switch key {
        case "energy": return "flame.fill"
        case "protein": return "bolt.heart.fill"
        case "carbohydrate": return "leaf.fill"
        case "sugars", "sugar": return "cube.fill"
        case "fat", "saturated_fat", "saturatedFat": return "drop.fill"
        case "sodium": return "aqi.medium"
        default: return "chart.bar.fill"
        }
    }

    private func nutritionColor(for key: String) -> Color {
        switch key {
        case "energy": return Color("ColorPrimary")
        case "protein": return Color("ColorPrimary")
        case "carbohydrate": return Color("ColorPrimary")
        case "sugars", "sugar": return Color("ColorPrimary")
        case "fat", "saturated_fat", "saturatedFat": return Color("ColorPrimary")
        case "sodium": return Color("ColorPrimary")
        default: return Color("ColorPrimary")
        }
    }
}

private struct ProductInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .frame(width: 110, alignment: .leading)

            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AnalystView(
            product: Product(
                productName: "Bánh quy ABC",
                ageRange: "3+",
                ingredients: [
                    "Bột mì",
                    "Đường",
                    "Dầu thực vật"
                ],
                additive: [
                    "INS 322",
                    "INS 500(ii)"
                ],
                nutrition: [
                    "energy": "250 kcal",
                    "protein": "12g",
                    "fat": "10g",
                    "saturatedFat": "3g",
                    "transFat": "0g",
                    "carbohydrate": "30g",
                    "sugar": "12g",
                    "fiber": "5g",
                    "sodium": "200mg"
                ],
                manufacturer: "ABC Food",
                mfgDate: "2026-01-01",
                expiryDate: "2027-01-01",
                netWeight: "200 g",
                warning: "Nhiều đường",
                origin: "Việt Nam"
            ),
            onDismiss: {}
        )
    }
}
