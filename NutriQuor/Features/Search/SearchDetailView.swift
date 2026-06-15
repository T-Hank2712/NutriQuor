//
//  SearchDetailView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct SearchDetailView: View {
    let id: String

    @StateObject private var viewModel = SearchNutritionViewModel()
    
    @Environment(\.dismiss) private var dismiss

    // Tạm dùng "AVOID" cứng — sau này có thể truyền vào từ data
    private let verdict: Verdict = .avoid

    private enum Verdict {
        case safe, caution, avoid

        var label: String {
            switch self {
            case .safe:    return "AN TOÀN"
            case .caution: return "CẨN THẬN"
            case .avoid:   return "NÊN TRÁNH"
            }
        }
        var icon: String {
            switch self {
            case .safe:    return "checkmark.shield.fill"
            case .caution: return "exclamationmark.shield.fill"
            case .avoid:   return "xmark.shield.fill"
            }
        }
        var color: Color {
            switch self {
            case .safe:    return Color("SuccessTeal")
            case .caution: return Color("WarningAmber")
            case .avoid:   return Color("AccentPink")
            }
        }
        var bgColor: Color { color.opacity(0.12) }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                // MARK: - Hero
                ZStack(alignment: .bottom) {
                    // Background gradient
                    LinearGradient(
                        colors: [
                            Color("SoftPink1"),
                            Color("SoftPink2"),
                            Color("ColorPrimary").opacity(0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 260)

                    // Decorative circles
                    Circle()
                        .fill(Color("ColorPrimary").opacity(0.2))
                        .frame(width: 200)
                        .offset(x: 100, y: -40)

                    Circle()
                        .fill(Color("ColorPrimary").opacity(0.15))
                        .frame(width: 140)
                        .offset(x: -80, y: 20)

                    VStack(spacing: 16) {
                        // Icon / Image
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: 110, height: 110)
                                .shadow(color: Color("ColorPrimary").opacity(0.3), radius: 20, y: 8)

                            Image(systemName: "leaf.fill")
                                .font(.system(size: 44, weight: .semibold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color("ColorPrimary"), Color("AccentPinkLight")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }

                        // Verdict badge
                        HStack(spacing: 6) {
                            Image(systemName: verdict.icon)
                                .font(.system(size: 13, weight: .bold))
                            Text(verdict.label)
                                .font(.system(size: 12, weight: .black, design: .rounded))
                                .kerning(0.5)
                        }
                        .foregroundStyle(verdict.color)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(
                            Capsule()
                                .fill(verdict.bgColor)
                                .overlay(
                                    Capsule().stroke(verdict.color.opacity(0.3), lineWidth: 1)
                                )
                        )
                    }
                    .padding(.bottom, 28)
                }

                // MARK: - Content
                if let data = viewModel.detail{
                    let foundIn = data.foundIn ?? []
                    let effects = data.effects ?? []
                    VStack(spacing: 24) {

                        // Name + Tags
                        VStack(spacing: 12) {
                            Text(data.name)
                                .font(.system(size: 28, weight: .black, design: .rounded))
                                .foregroundStyle(.primary)
                                .kerning(-0.5)
                                .multilineTextAlignment(.center)

//                            HStack(spacing: 8) {
//                                ForEach([data.code, data.type].compactMap { $0 }, id: \.self) { tag in
//                                    Text(tag)
//                                        .font(.system(size: 12, weight: .bold, design: .rounded))
//                                        .foregroundStyle(Color("AccentPinkLight"))
//                                        .padding(.horizontal, 12)
//                                        .padding(.vertical, 5)
//                                        .background(
//                                            Capsule()
//                                                .fill(Color("ColorPrimary").opacity(0.15))
//                                                .overlay(
//                                                    Capsule()
//                                                        .stroke(Color("ColorPrimary").opacity(0.3), lineWidth: 1)
//                                                )
//                                        )
//                                }
//                            }
                        }
                        .padding(.top, 24)

                        // Description
                        DetailSection(title: "Đây là gì?", icon: "info.circle.fill", iconColor: Color("ColorPrimary")) {
                            Text(data.description ?? "")
                                .font(.system(size: 15))
                                .foregroundStyle(.secondary)
                                .lineSpacing(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        // Health Impact
                        DetailSection(title: "Tác động sức khoẻ", icon: "shield.fill", iconColor: verdict.color) {
                            VStack(spacing: 10) {
                                ForEach(effects) { effect in
                                    HStack(spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(verdict.color.opacity(0.1))
                                                .frame(width: 34, height: 34)
                                            Image(systemName: verdict.icon)
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(verdict.color)
                                        }
    
                                        Text(effect.title)
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundStyle(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(verdict.color.opacity(0.05))
                                    )
                                }
                            }
                        }

                        // Found In
                        DetailSection(title: "Thường có trong", icon: "bag.fill", iconColor: Color("AccentPurple")) {
                            LazyVGrid(
                                columns: [GridItem(.flexible()), GridItem(.flexible())],
                                spacing: 10
                            ) {
                                ForEach(foundIn, id: \.id) { found in
                                    HStack(spacing: 8) {
                                        Image(systemName: "cup.and.saucer.fill")
                                            .font(.system(size: 13))
                                            .foregroundStyle(Color("AccentPurple").opacity(0.7))
                                        Text(found.name)
                                            .font(.system(size: 13, weight: .medium, design: .rounded))
                                            .foregroundStyle(.primary)
                                            .lineLimit(1)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("AccentPurple").opacity(0.06))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color("AccentPurple").opacity(0.1), lineWidth: 1)
                                            )
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
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
}

// MARK: - Detail Section Card
struct DetailSection<Content: View>: View {
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }
}

#Preview {
    NavigationStack {
        SearchDetailView(id: "1")
    }
}
