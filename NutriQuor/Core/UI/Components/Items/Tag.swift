//
//  Tag.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/3/26.
//

import SwiftUI

struct Tag: View {
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 6, height: 6)

            Text(text)
                .font(.caption.weight(.medium))
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .overlay {
            Capsule()
                .stroke(.gray.opacity(0.15), lineWidth: 1)
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        Tag(text: "Vegan", color: .green)
        Tag(text: "High Protein", color: .blue)
        Tag(text: "Low Sugar", color: .orange)
    }
    .padding()
}
