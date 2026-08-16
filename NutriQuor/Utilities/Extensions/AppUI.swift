//
//  CGFloat.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/3/26.
//

import SwiftUI

extension CGFloat {
    // MARK: Radius
    static let cardRadius: CGFloat = 24
    static let smallRadius: CGFloat = 16
    static let pillRadius: CGFloat = 999
    
}

extension Double {
    
    // MARK: Opacity
    static let opacityLight: Double = 0.1
    static let opacityMedium: Double = 0.3
    static let opacityStrong: Double = 0.6
    
}

extension Font {
    static let heading1 = Font.system(size: 38, weight: .black, design: .rounded)
    static let heading3 = Font.system(size: 24, weight: .bold, design: .rounded)
    static let title = Font.system(size: 20, weight: .bold, design: .rounded)
    static let text = Font.system(size: 16, weight: .regular, design: .rounded)
}

enum AppSpacing {
    static let page: CGFloat = 20
    static let section: CGFloat = 24
    static let card: CGFloat = 16
}

struct PressScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.965 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.78), value: configuration.isPressed)
    }
}

extension View {
    func glassPanel(cornerRadius: CGFloat = .cardRadius, borderOpacity: Double = 0.18) -> some View {
        modifier(GlassPanelModifier(cornerRadius: cornerRadius, borderOpacity: borderOpacity))
    }

    func shimmer(active: Bool = true) -> some View {
        modifier(ShimmerModifier(active: active))
    }
}

private struct GlassPanelModifier: ViewModifier {
    @Environment(\.colorScheme) private var scheme
    let cornerRadius: CGFloat
    let borderOpacity: Double

    func body(content: Content) -> some View {
        content
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color("Border").opacity(scheme == .dark ? 0.8 : borderOpacity), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.black.opacity(scheme == .dark ? 0.20 : 0.035), radius: 10, y: 4)
    }
}

private struct ShimmerModifier: ViewModifier {
    let active: Bool
    @State private var phase: CGFloat = -0.8

    func body(content: Content) -> some View {
        content
            .overlay {
                if active {
                    GeometryReader { proxy in
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0),
                                Color.white.opacity(0.38),
                                Color.white.opacity(0)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .rotationEffect(.degrees(18))
                        .offset(x: proxy.size.width * phase)
                        .blendMode(.plusLighter)
                    }
                    .mask(content)
                    .allowsHitTesting(false)
                }
            }
            .onAppear {
                guard active else { return }
                withAnimation(.linear(duration: 1.35).repeatForever(autoreverses: false)) {
                    phase = 1.2
                }
            }
    }
}

struct SkeletonLine: View {
    var height: CGFloat = 14
    var width: CGFloat? = nil

    var body: some View {
        RoundedRectangle(cornerRadius: height / 2, style: .continuous)
            .fill(Color.primary.opacity(0.08))
            .frame(width: width, height: height)
            .shimmer()
    }
}
