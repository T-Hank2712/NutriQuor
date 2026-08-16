//
//  CountScansCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct CountScansCard: View {
    
    var count: Int
    
    var body: some View {
        BentoCard(accent: Color("ColorPrimary"), style: .tinted, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "viewfinder.circle.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("ColorPrimary"))
                        .frame(width: 42, height: 42)
                        .background(
                            RoundedRectangle(cornerRadius: .cardRadius)
                                .fill(Color("ColorPrimary").opacity(0.12))
                        )

                    Spacer()
                }
            
                Text("LƯỢT QUÉT HÔM NAY")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondary)
            
                HStack(alignment: .lastTextBaseline, spacing: 6) {
                    Text("\(count)")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundStyle(Color("Heading"))

                    Text("lượt")
                        .font(.caption)
                        .foregroundStyle(Color("ColorPrimary"))
                }
                .lineLimit(1)
            }
            .frame(maxWidth: .infinity, minHeight: 144, maxHeight: 144, alignment: .leading)
        }
    }
}

#Preview {
    CountScansCard(count: 27)
}
