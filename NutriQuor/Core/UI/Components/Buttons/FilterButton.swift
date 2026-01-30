//
//  FillterButoon.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 30/1/26.
//

import SwiftUI

struct FilterButton: View {
    let title: String

    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.subheadline)
            Image(systemName: "chevron.down")
                .font(.caption)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .stroke(Color.gray.opacity(0.3))
        )
    }
}

#Preview {
    FilterButton(title: "Week")
}
