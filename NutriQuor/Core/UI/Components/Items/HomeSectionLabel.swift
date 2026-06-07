//
//  HomeSectionLabel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct SectionLabel: View {
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color("ColorPrimary"))
                .frame(width: 3, height: 14)
            Text(text)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
                .kerning(1.2)
        }
    }
}

#Preview {
    SectionLabel(text: "LỊCH SỬ QUÉT GẦN ĐÂY")
        .padding()
}
