//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//

import SwiftUI

struct AnalystView: View {
    let nutriItem: History
    let onDismiss: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var selectedRow: NutriText?

    private var scoreColor: Color {
        switch nutriItem.score.lowercased() {
        case "tốt":  return Color("SuccessTeal")
        case "xấu":  return Color("AccentPink")
        default:     return Color("ColorPrimary")
        }
    }

    private var scoreIcon: String {
        switch nutriItem.score.lowercased() {
        case "tốt":  return "checkmark.shield.fill"
        case "xấu":  return "xmark.shield.fill"
        default:     return "minus.shield.fill"
        }
    }

    var body: some View {
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

                            nutriItem.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        }

                        // Score badge
                        HStack(spacing: 6) {
                            Image(systemName: scoreIcon)
                                .font(.system(size: 13, weight: .bold))
                            Text(nutriItem.score.uppercased())
                                .font(.system(size: 12, weight: .black, design: .rounded))
                                .kerning(0.5)
                        }
                        .foregroundStyle(scoreColor)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(
                            Capsule()
                                .fill(scoreColor.opacity(0.1))
                                .overlay(Capsule().stroke(scoreColor.opacity(0.3), lineWidth: 1))
                        )
                    }
                    .padding(.bottom, 28)
                }

                // MARK: - Content
                VStack(spacing: 22) {

                    // Product name + tags
                    VStack(spacing: 10) {
                        Text(nutriItem.title)
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
                    .padding(.top, 24)

                    // MARK: - Nutrition
                    AnalystSection(title: "Dinh dưỡng", icon: "chart.bar.fill", iconColor: Color("ColorPrimary")) {
                        HStack(spacing: 12) {
                            ModernNutrientCard(title: "PROTEIN", value: "8g",  color: Color("AccentPink"), icon: "flame.fill")
                            ModernNutrientCard(title: "CARBS",   value: "12g", color: Color("AccentOrange"), icon: "bolt.fill")
                            ModernNutrientCard(title: "FAT",     value: "14g", color: Color("SuccessTeal"), icon: "drop.fill")
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

                            Button {
                                print("View All")
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
                        Circle()
                            .fill(.white.opacity(0.9))
                            .frame(width: 34, height: 34)
                            .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
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

// MARK: - Analyst Section
struct AnalystSection<Content: View>: View {
    let title: String
    let icon: String
    let iconColor: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconColor.opacity(0.12))
                        .frame(width: 30, height: 30)
                    Image(systemName: icon)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(iconColor)
                }
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
            }
            content
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }
}

// MARK: - Modern Nutrient Card
struct ModernNutrientCard: View {
    let title: String
    let value: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(color)
            }
            Text(value)
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundStyle(.primary)
            Text(title)
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
                .kerning(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.15), lineWidth: 1)
                )
        )
    }
}

// MARK: - Modern Alert Row
struct ModernAlertRow: View {
    let icon: String
    let color: Color
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(0.1))
                    .frame(width: 38, height: 38)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
                Text(description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(color.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(color.opacity(0.15), lineWidth: 1)
                )
        )
    }
}

// MARK: - Modern Contain Card
struct ModernContainCard: View {
    let title: String
    let good: String
    let bad: String
    let goodColor: Color
    let badColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            if !good.isEmpty {
                HStack(spacing: 6) {
                    Circle().fill(goodColor).frame(width: 7, height: 7)
                    Text(good)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(goodColor)
                }
            }

            if !bad.isEmpty {
                HStack(spacing: 6) {
                    Circle().fill(badColor).frame(width: 7, height: 7)
                    Text(bad)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(badColor)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

// MARK: - Analyst Option Row
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

// MARK: - Preview
#Preview {
    NavigationStack {
        AnalystView(
            nutriItem: History(
                image: Image("Example"),
                title: "Bánh quy ABC",
                warning: "Nhiều đường",
                score: "Xấu",
                time: Calendar.current.date(
                    from: DateComponents(year: 2025, month: 1, day: 24, hour: 21, minute: 04)
                )!
            ),
            onDismiss: {}
        )
    }
}
