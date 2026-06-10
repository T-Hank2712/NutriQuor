//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//

import SwiftUI

struct AnalystView: View {
    let product: ProductDTO
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
        let id = UUID()
        let title: String
        let value: String?
        let color: Color
        let icon: String
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
                                Color("ColorPrimary").opacity(0.25)
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
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white)
                                    .frame(width: 110, height: 110)
                                    .shadow(color: Color("ColorPrimary").opacity(0.3), radius: 20, y: 8)

                                Image("Example")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 24))
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
                            Text(product.productName)
                                .font(.system(size: 26, weight: .black, design: .rounded))
                                .foregroundStyle(.primary)
                                .kerning(-0.4)
                                .multilineTextAlignment(.center)

                            HStack(spacing: 8) {
                                ForEach(["Drink", "Healthy"], id: \.self) { tag in
                                    Text(tag)
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color("AccentPinkLight"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 5)
                                        .background(
                                            Capsule()
                                                .fill(Color("ColorPrimary").opacity(0.15))
                                                .overlay(Capsule().stroke(Color("ColorPrimary").opacity(0.3), lineWidth: 1))
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
                                            ModernNutrientCard(
                                                title: item.title,
                                                value: item.value ?? "0",
                                                color: item.color,
                                                icon: item.icon
                                            )
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
                                ModernAlertRow(
                                    icon: "exclamationmark.triangle.fill",
                                    color: Color("WarningAmber"),
                                    title: "Cảnh báo",
                                    description: "Không dành cho trẻ em dưới 3 tuổi."
                                )
                                ModernAlertRow(
                                    icon: "allergens",
                                    color: Color("AccentPink"),
                                    title: "Dị ứng",
                                    description: "Sản phẩm có chứa Sữa."
                                )
                            }
                        }

                        // MARK: - Contains
                        AnalystSection(title: "Thành phần", icon: "list.bullet.clipboard.fill", iconColor: Color("AccentPurple")) {
                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    ModernContainCard(
                                        title: "Thành phần",
                                        good: "6 Tốt",
                                        bad: "2 Hạn chế",
                                        goodColor: Color("SuccessTeal"),
                                        badColor: Color("WarningAmber")
                                    )
                                    ModernContainCard(
                                        title: "Phụ gia",
                                        good: "",
                                        bad: "6 Phụ gia",
                                        goodColor: Color("SuccessTeal"),
                                        badColor: Color("AccentPink")
                                    )
                                }

                                NavigationLink {
                                    ContainListView()
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

                        // MARK: - Options
                        AnalystSection(title: "Tuỳ chọn", icon: "ellipsis.circle.fill", iconColor: Color("ColorPrimary")) {
                            VStack(spacing: 10) {
                                AnalystOptionRow(
                                    title: "Thêm vào yêu thích",
                                    icon: "heart.fill",
                                    color: Color("AccentPink")
                                )
                                Divider().padding(.leading, 48)
                                AnalystOptionRow(
                                    title: "Chia sẻ sản phẩm",
                                    icon: "square.and.arrow.up.fill",
                                    color: Color("AccentPurple")
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
                    Button { dismiss() } label: {
                        ZStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private var nutritionItems: [NutrientItem] {
        guard let nutrition = product.nutrition else { return [] }

        return [
            .init(title: "ENERGY", value: nutrition.energy, color: Color("AccentOrange"), icon: "bolt.fill"),
            .init(title: "PROTEIN", value: nutrition.protein, color: Color("AccentPink"), icon: "flame.fill"),
            .init(title: "FAT", value: nutrition.fat, color: Color("SuccessTeal"), icon: "drop.fill"),
            .init(title: "SUGAR", value: nutrition.sugar, color: Color("ColorPrimary"), icon: "cube.fill"),
            .init(title: "CARB", value: nutrition.carbohydrate, color: Color("AccentOrange"), icon: "leaf.fill"),
            .init(title: "FIBER", value: nutrition.fiber, color: Color("SuccessTeal"), icon: "leaf.circle.fill"),
            .init(title: "SODIUM", value: nutrition.sodium, color: Color("AccentPink"), icon: "drop.triangle.fill"),
            .init(title: "SAT FAT", value: nutrition.saturatedFat, color: Color("WarningAmber"), icon: "flame"),
            .init(title: "TRANS FAT", value: nutrition.transFat, color: Color("AccentPurple"), icon: "xmark.octagon.fill")
        ]
    }
    
    private var displayNutritionItems: [NutrientItem] {
        showAllNutrition ? nutritionItems : Array(nutritionItems.prefix(6))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AnalystView(
            product: ProductDTO(
                id: 1,
                userId: 1,
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
                nutrition: ProductDTO.Nutrition(
                    energy: "250 kcal",
                    protein: "12g",
                    fat: "10g",
                    saturatedFat: "3g",
                    transFat: "0g",
                    carbohydrate: "30g",
                    sugar: "12g",
                    fiber: "5g",
                    sodium: "200mg"
                ),
                manufacturer: "ABC Food",
                mfgDate: "2026-01-01",
                expiryDate: "2027-01-01",
                netWeight: "200 g",
                allergen: "Gluten",
                warning: "Nhiều đường",
                origin: "Việt Nam",
                createdAt: "2026-06-09T05:27:07.241790Z",
                timeZone: "Asia/Ho_Chi_Minh",
                createdAtLocal: Date()
            ),
            onDismiss: {}
        )
    }
}
