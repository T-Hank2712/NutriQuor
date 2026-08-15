//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//

import SwiftUI

struct AnalystView: View {
    let product: Product
    let onDismiss: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var selectedRow: NutriText?
    @State private var showAllNutrition = false

//    private var scoreColor: Color {
//        switch nutriItem.score.lowercased() {
//        case "tốt":  return Color("SuccessTeal")
//        case "xấu":  return Color("AccentPink")
//        default:     return Color("ColorPrimary")
//        }
//    }
//
//    private var scoreIcon: String {
//        switch nutriItem.score.lowercased() {
//        case "tốt":  return "checkmark.shield.fill"
//        case "xấu":  return "xmark.shield.fill"
//        default:     return "minus.shield.fill"
//        }
//    }
    
    struct NutrientItem: Identifiable {
        let id: String
        let title: String
        let value: String?
        let color: Color
        let icon: String
        let detailID: String?
    }

    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: - Hero
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            colors: [
                                Color("SoftPink1"),
                                Color("SoftPink2"),
                                Color("SuccessTeal").opacity(0.18)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 280)

                        Circle()
                            .fill(Color("ColorPrimary").opacity(0.18))
                            .frame(width: 220)
                            .offset(x: 110, y: -30)

                        Circle()
                            .fill(Color("ColorPrimary").opacity(0.12))
                            .frame(width: 160)
                            .offset(x: -90, y: 20)

                        VStack(spacing: 14) {
                            // Product image
                            ZStack {
                                RoundedRectangle(cornerRadius: .cardRadius)
                                    .fill(.white)
                                    .frame(width: 110, height: 110)
                                    .shadow(color: Color("ColorPrimary").opacity(0.16), radius: 16, y: 6)

                                ScanHistoryThumbnail(
                                    imageUrl: product.imageUrl,
                                    size: 110
                                )
                            }

                            // Score badge
//                            HStack(spacing: 6) {
//                                Image(systemName: scoreIcon)
//                                    .font(.system(size: 13, weight: .bold))
//                                Text(nutriItem.score.uppercased())
//                                    .font(.system(size: 12, weight: .black, design: .rounded))
//                                    .kerning(0.5)
//                            }
//                            .foregroundStyle(scoreColor)
//                            .padding(.horizontal, 14)
//                            .padding(.vertical, 7)
//                            .background(
//                                Capsule()
//                                    .fill(scoreColor.opacity(0.1))
//                                    .overlay(Capsule().stroke(scoreColor.opacity(0.3), lineWidth: 1))
//                            )
                        }
                        .padding(.bottom, 28)
                    }

                    // MARK: - Content
                    VStack(spacing: 22) {

                        // Product name + tags
                        VStack(spacing: 10) {
                            Text(product.productName ?? "Kết quả phân tích")
                                .font(.system(size: 26, weight: .black, design: .rounded))
                                .foregroundStyle(.primary)
                                .kerning(-0.4)
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
                        .padding(.top, 10)

                        // MARK: - Nutrition
                        AnalystSection(title: "Dinh dưỡng",
                                       icon: "chart.bar.fill",
                                       iconColor: Color("ColorPrimary")) {

                            if !nutritionItems.isEmpty {

                                let displayItems = showAllNutrition
                                    ? nutritionItems
                                    : Array(nutritionItems.prefix(3))

                                VStack(spacing: 12) {

                                    LazyVGrid(
                                        columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
                                        spacing: 12
                                    ) {
                                        ForEach(displayItems) { item in
                                            if let detailID = item.detailID {
                                                NavigationLink {
                                                    SearchDetailView(id: detailID)
                                                } label: {
                                                    ModernNutrientCard(
                                                        title: item.title,
                                                        value: item.value ?? "0",
                                                        color: item.color,
                                                        icon: item.icon
                                                    )
                                                }
                                                .buttonStyle(.plain)
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
                        AnalystSection(title: "Cảnh báo", icon: "exclamationmark.triangle.fill", iconColor: Color("WarningAmber")) {
                            VStack(spacing: 10) {
                                if let warning = product.warning, !warning.isEmpty {
                                    ModernAlertRow(
                                        icon: "exclamationmark.triangle.fill",
                                        color: Color("WarningAmber"),
                                        title: "Cảnh báo",
                                        description: warning
                                    )
                                }

                                if product.warning?.isEmpty ?? true {
                                    ModernAlertRow(
                                        icon: "checkmark.shield.fill",
                                        color: Color("SuccessTeal"),
                                        title: "Không có cảnh báo",
                                        description: "Chưa phát hiện cảnh báo từ kết quả phân tích."
                                    )
                                }
                            }
                        }

                        // MARK: - Contains
                        AnalystSection(title: "Thành phần", icon: "list.bullet.clipboard.fill", iconColor: Color("ColorPrimary")) {
                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    ModernContainCard(
                                        title: "Thành phần",
                                        good: "\(product.ingredients.count) mục",
                                        bad: "Từ nhãn sản phẩm",
                                        goodColor: Color("SuccessTeal"),
                                        badColor: Color("WarningAmber")
                                    )
                                    ModernContainCard(
                                        title: "Phụ gia",
                                        good: "",
                                        bad: "\(product.additive.count) phụ gia",
                                        goodColor: Color("SuccessTeal"),
                                        badColor: Color("AccentOrange")
                                    )
                                }
//
//                                if !product.additiveItems.isEmpty {
//                                    VStack(spacing: 10) {
//                                        ForEach(Array(product.additiveItems.prefix(3).enumerated()), id: \.element.stableID) { index, item in
//                                            if let id = item.id, !id.isEmpty {
//                                                NavigationLink {
//                                                    SearchDetailView(id: id)
//                                                } label: {
//                                                    IngredientCard(
//                                                        title: item.displayName,
//                                                        index: index + 1,
//                                                        status: .caution
//                                                    )
//                                                }
//                                                .buttonStyle(.plain)
//                                            } else {
//                                                IngredientCard(
//                                                    title: item.displayName,
//                                                    index: index + 1,
//                                                    status: .caution
//                                                )
//                                            }
//                                        }
//                                    }
//                                }

                                NavigationLink {
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

                        if !detailRows.isEmpty {
                            AnalystSection(title: "Thông tin sản phẩm", icon: "info.circle.fill", iconColor: Color("InfoBlue")) {
                                VStack(spacing: 10) {
                                    ForEach(detailRows, id: \.title) { row in
                                        ProductInfoRow(title: row.title, value: row.value)
                                    }
                                }
                            }
                        }

                        // MARK: - Options
                        AnalystSection(title: "Tuỳ chọn", icon: "ellipsis.circle.fill", iconColor: Color("ColorPrimary")) {
                            VStack(spacing: 10) {
                                AnalystOptionRow(
                                    title: "Thêm vào yêu thích",
                                    icon: "heart.fill",
                                    color: Color("ColorPrimary")
                                )
                                Divider().padding(.leading, 48)
                                AnalystOptionRow(
                                    title: "Chia sẻ sản phẩm",
                                    icon: "square.and.arrow.up.fill",
                                    color: Color("InfoBlue")
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarBackButtonHidden(true)
            .toolbar {
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
            .background(Color("Background"))
        }
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
        case "energy": return Color("AccentOrange")
        case "protein": return Color("SuccessTeal")
        case "carbohydrate": return Color("ColorPrimary")
        case "sugars", "sugar": return Color("AccentPink")
        case "fat", "saturated_fat", "saturatedFat": return Color("WarningAmber")
        case "sodium": return Color("InfoBlue")
        default: return Color("AccentPurple")
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
