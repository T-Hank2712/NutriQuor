//
//  BentoCard.swift
//  NutriQuor
//

import SwiftUI

enum BentoCardStyle {
    case plain
    case tinted
    case elevated
}

struct BentoCard<Content: View>: View {
    let accent: Color
    var style: BentoCardStyle = .plain
    var padding: CGFloat = 16
    @ViewBuilder let content: Content
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(background)
            .overlay(border)
            .clipShape(RoundedRectangle(cornerRadius: .cardRadius, style: .continuous))
            .shadow(
                color: Color.black.opacity(scheme == .dark ? 0.22 : (style == .elevated ? 0.07 : 0.025)),
                radius: style == .elevated ? 14 : 8,
                y: style == .elevated ? 7 : 3
            )
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
            .fill(backgroundColor)
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
            .stroke(borderColor, lineWidth: 1)
    }

    private var backgroundColor: Color {
        switch style {
        case .plain:
            return Color(.secondarySystemGroupedBackground)
        case .tinted:
            return accent.opacity(scheme == .dark ? 0.12 : 0.07)
        case .elevated:
            return Color(.systemBackground)
        }
    }

    private var borderColor: Color {
        style == .tinted
            ? accent.opacity(scheme == .dark ? 0.22 : 0.16)
            : Color("Border").opacity(scheme == .dark ? 0.8 : 0.65)
    }
}

#Preview {
    BentoCard(accent: Color("ColorPrimary"), style: .tinted) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ô thông tin")
                .font(.headline)
            Text("Bề mặt hiển thị thông tin sức khỏe.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    .padding()
    .background(Color("Background"))
}
