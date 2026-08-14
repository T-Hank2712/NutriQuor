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
            .overlay(alignment: .topTrailing) {
                Circle()
                    .fill(accent.opacity(style == .plain ? 0.10 : 0.18))
                    .blur(radius: 18)
                    .frame(width: 68, height: 68)
                    .offset(x: 22, y: -24)
            }
            .clipShape(RoundedRectangle(cornerRadius: .cardRadius, style: .continuous))
            .shadow(
                color: Color.black.opacity(scheme == .dark ? 0.30 : (style == .elevated ? 0.09 : 0.05)),
                radius: style == .elevated ? 22 : 16,
                y: style == .elevated ? 12 : 8
            )
    }

    private var background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                .fill(.ultraThinMaterial)

            RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: backgroundColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
            .stroke(
                LinearGradient(
                    colors: [
                        Color.white.opacity(scheme == .dark ? 0.18 : 0.55),
                        accent.opacity(style == .plain ? 0.12 : 0.24)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }

    private var backgroundColors: [Color] {
        switch style {
        case .plain:
            return [
                Color(.systemBackground).opacity(scheme == .dark ? 0.10 : 0.72),
                Color(.systemBackground).opacity(scheme == .dark ? 0.06 : 0.52)
            ]
        case .tinted:
            return [
                Color(.systemBackground).opacity(scheme == .dark ? 0.10 : 0.70),
                accent.opacity(scheme == .dark ? 0.16 : 0.10)
            ]
        case .elevated:
            return [
                Color(.systemBackground).opacity(scheme == .dark ? 0.16 : 0.82),
                Color("Background").opacity(scheme == .dark ? 0.18 : 0.70)
            ]
        }
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
