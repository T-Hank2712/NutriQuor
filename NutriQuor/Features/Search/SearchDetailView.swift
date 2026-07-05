//
//  SearchDetailView.swift
//  NutriQuor
//

import SwiftUI

struct SearchDetailView: View {
    let id: String

    @StateObject private var viewModel = SearchNutritionViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                hero

                if let detail = viewModel.detail {
                    detailContent(detail)
                } else {
                    loadingContent
                }
            }
        }
        .task {
            await viewModel.loadDetail(id: id)
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

    private var hero: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [
                    Color("SoftPink1"),
                    Color("SoftPink2"),
                    Color("ColorPrimary").opacity(0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 250)

            Circle()
                .fill(Color("ColorPrimary").opacity(0.2))
                .frame(width: 200)
                .offset(x: 105, y: -45)

            Circle()
                .fill(Color("AccentPinkLight").opacity(0.16))
                .frame(width: 150)
                .offset(x: -90, y: 18)

            ZStack {
                RoundedRectangle(cornerRadius: 26)
                    .fill(.white)
                    .frame(width: 112, height: 112)
                    .shadow(color: Color("ColorPrimary").opacity(0.3), radius: 20, y: 8)

                Image(systemName: heroIcon)
                    .font(.system(size: 44, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [heroColor, Color("AccentPinkLight")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .padding(.bottom, 28)
        }
    }

    private func detailContent(_ detail: SearchDetailDTO) -> some View {
        VStack(spacing: 22) {
            VStack(spacing: 12) {
                Text(detail.name)
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)

                HStack(spacing: 8) {
                    if let type = itemType {
                        DetailChip(text: type.displayName, color: heroColor)
                    }

                    if let code = detail.code, !code.isEmpty {
                        DetailChip(text: code, color: Color("AccentPink"))
                    }

                    DetailChip(text: "\(detail.sections.count) mục", color: Color("AccentPurple"))
                }
            }
            .padding(.top, 24)

            if detail.sections.isEmpty {
                DetailSection(
                    title: "Chưa có nội dung",
                    icon: "doc.text.magnifyingglass",
                    iconColor: Color("MutedMauve")
                ) {
                    Text(detail.description ?? "API chưa trả về section mô tả cho mục này.")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.secondary)
                        .lineSpacing(5)
                }
            } else {
                ForEach(detail.sections) { section in
                    DetailSection(
                        title: section.displayTitle,
                        icon: section.displayIcon,
                        iconColor: section.displayColor
                    ) {
                        Text(section.content)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.secondary)
                            .lineSpacing(6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }

    private var loadingContent: some View {
        VStack(spacing: 14) {
            ProgressView()
                .tint(Color("ColorPrimary"))

            Text("Đang tải thông tin")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 48)
    }

    private var itemType: SearchItemType? {
        SearchItemType(id: id)
    }

    private var heroIcon: String {
        itemType?.icon ?? "leaf.fill"
    }

    private var heroColor: Color {
        itemType?.color ?? Color("ColorPrimary")
    }
}

private struct DetailChip: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundStyle(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(color.opacity(0.12))
                    .overlay(Capsule().stroke(color.opacity(0.22), lineWidth: 1))
            )
    }
}

struct DetailSection<Content: View>: View {
    let title: String
    let icon: String
    let iconColor: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(iconColor.opacity(0.12))
                        .frame(width: 34, height: 34)
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(iconColor)
                }
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }
}

private enum SearchItemType {
    case ingredient
    case nutrient
    case additive

    init?(id: String) {
        if id.hasPrefix("ingredient-") || id.hasPrefix("INGREDIENT:") {
            self = .ingredient
        } else if id.hasPrefix("nutrient-") || id.hasPrefix("NUTRIENT:") {
            self = .nutrient
        } else if id.hasPrefix("additive-") || id.hasPrefix("ADDITIVE:") {
            self = .additive
        } else {
            return nil
        }
    }

    var displayName: String {
        switch self {
        case .ingredient: return "Thành phần"
        case .nutrient: return "Dinh dưỡng"
        case .additive: return "Phụ gia"
        }
    }

    var icon: String {
        switch self {
        case .ingredient: return "leaf.fill"
        case .nutrient: return "chart.bar.fill"
        case .additive: return "plus.square.fill"
        }
    }

    var color: Color {
        switch self {
        case .ingredient: return Color("SuccessTeal")
        case .nutrient: return Color("ColorPrimary")
        case .additive: return Color("AccentPink")
        }
    }
}

private extension KnowledgeSection {
    var displayTitle: String {
        switch sectionType {
        case "overview": return "Tổng quan"
        case "classification_and_role": return "Phân loại & vai trò"
        case "health_effects": return "Tác động sức khoẻ"
        case "common_sources": return "Nguồn thường gặp"
        case "usage_and_limits": return "Cách dùng & giới hạn"
        default:
            return sectionType
                .replacingOccurrences(of: "_", with: " ")
                .capitalized
        }
    }

    var displayIcon: String {
        switch sectionType {
        case "overview": return "info.circle.fill"
        case "classification_and_role": return "square.grid.2x2.fill"
        case "health_effects": return "heart.text.square.fill"
        case "common_sources": return "bag.fill"
        case "usage_and_limits": return "exclamationmark.triangle.fill"
        default: return "doc.text.fill"
        }
    }

    var displayColor: Color {
        switch sectionType {
        case "overview": return Color("ColorPrimary")
        case "classification_and_role": return Color("AccentPurple")
        case "health_effects": return Color("AccentPink")
        case "common_sources": return Color("SuccessTeal")
        case "usage_and_limits": return Color("WarningAmber")
        default: return Color("InfoBlue")
        }
    }
}

#Preview {
    NavigationStack {
        SearchDetailView(id: "ingredient-INGREDIENT:FOODON_03310351")
    }
}
