//
//  SearchDetailView.swift
//  NutriQuor
//

import SwiftUI

struct SearchDetailView: View {
    let id: String

    @StateObject private var viewModel = SearchNutritionViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
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
        .background(Color("Background"))
        .hideBottomBarOnDetail()
    }

    private var hero: some View {
        BentoCard(accent: heroColor, style: .tinted, padding: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(heroColor.opacity(0.10))
                    .frame(width: 84, height: 84)
                    .overlay(
                        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                            .stroke(heroColor.opacity(0.16), lineWidth: 1)
                    )

                Image(systemName: heroIcon)
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(heroColor)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 14)
    }

    private func detailContent(_ detail: SearchDetailDTO) -> some View {
        VStack(spacing: 22) {
            VStack(spacing: 12) {
                Text(detail.displayName)
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)

                HStack(spacing: 8) {
                    if let type = itemType {
                        DetailChip(text: type.displayName, color: heroColor)
                    }

                    if let code = detail.code, !code.isEmpty {
                        DetailChip(text: code, color: Color("ColorPrimary"))
                    }

                    if let unit = detail.defaultUnit, !unit.isEmpty {
                        DetailChip(text: unit, color: Color("ColorPrimary"))
                    }

                    DetailChip(text: "\(detail.sections.count) mục", color: Color("ColorPrimary"))
                }
            }
            .padding(.top, 4)

            if detail.sections.isEmpty {
                DetailSection(
                    title: "Chưa có nội dung",
                    icon: "doc.text.magnifyingglass",
                    iconColor: Color("MutedMauve")
                ) {
                    Text(detail.description ?? "Nội dung mô tả cho mục này chưa sẵn sàng.")
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
        VStack(spacing: 18) {
            SkeletonLine(height: 24, width: 180)
                .padding(.top, 10)

            HStack(spacing: 8) {
                SkeletonLine(height: 26, width: 88)
                SkeletonLine(height: 26, width: 104)
                SkeletonLine(height: 26, width: 72)
            }

            ForEach(0..<3, id: \.self) { index in
                DetailSection(
                    title: index == 0 ? "Đang tải" : " ",
                    icon: "doc.text.fill",
                    iconColor: Color.nqPrimary.opacity(0.7)
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        SkeletonLine(height: 12)
                        SkeletonLine(height: 12)
                        SkeletonLine(height: 12, width: 210)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 40)
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
        .glassPanel()
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
        case .ingredient: return Color("ColorPrimary")
        case .nutrient: return Color("ColorPrimary")
        case .additive: return Color("ColorPrimary")
        }
    }
}

private extension KnowledgeSection {
    var displayTitle: String {
        if let title, !title.isEmpty {
            return title
        }

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
        case "classification_and_role": return Color("ColorPrimary")
        case "health_effects": return Color("ColorPrimary")
        case "common_sources": return Color("ColorPrimary")
        case "usage_and_limits": return Color("WarningAmber")
        default: return Color("ColorPrimary")
        }
    }
}

#Preview {
    NavigationStack {
        SearchDetailView(id: "ingredient-INGREDIENT:FOODON_03310351")
    }
}
