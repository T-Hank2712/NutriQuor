//
//  InsightCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 30/1/26.
//

import SwiftUI

struct InsightCard: View {
    let title: String
    let detail: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(title).foregroundStyle(color).font(Font.title2.bold())
            Text(detail).foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.2))
            )
    }
}

#Preview {
    InsightCard(title: "Warning", detail: "Không dùng cho trẻ em dưới 2 tuổi", color: .orange)
}
