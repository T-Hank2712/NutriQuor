//
//  IndexCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct IndexCard: View {
    var body: some View {
        BentoCard(accent: Color("SuccessTeal"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "shield.checkered")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("SuccessTeal"))
                        .frame(width: 36, height: 36)
                        .background(
                            RoundedRectangle(cornerRadius: .cardRadius)
                                .fill(Color("SuccessTeal").opacity(0.12))
                        )

                    Spacer()
                }
                   
                Text("CHỈ SỐ AN TOÀN")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondary)
                   
                ProgressView(value: 0.7)
                    .tint(Color("SuccessTeal"))
                   
                HStack {
                    Text("8 an toàn")
                        .font(.caption)
                        .foregroundColor(Color("SuccessTeal"))
                       
                    Spacer()
                       
                    Text("4 lưu ý")
                        .font(.caption)
                        .foregroundColor(Color("AccentOrange"))
                }
                   
                Text("70%")
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundStyle(Color("Heading"))
            }
            .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        }
    }
}

#Preview {
    IndexCard()
}
