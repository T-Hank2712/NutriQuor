//
//  InsightCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 30/1/26.
//

import SwiftUI

struct OptionCard: View {
    let title: String
       let icon: String
       let color: Color

       var body: some View {
           HStack{
               Image(systemName: icon)
                   .font(.system(size: 24))
                   .foregroundStyle(Color.nqPrimary)
               Text(title)
                   .font(.system(size: 18))
                   .fontWeight(.medium)
                   .foregroundColor(Color.nqPrimary)

               Spacer()
               
               Image(systemName: "chevron.right")
                   .font(.system(size: 20))
                   .foregroundStyle(.secondary)
           }
           .padding(.horizontal, 16)
           .padding(.vertical, 14)
           .frame(maxWidth: .infinity)
           .background(
            Capsule()
                .fill(Color(.systemBackground))
                .overlay(
                    Capsule()
                        .stroke(
                            color.opacity(.opacityMedium),
                            lineWidth: 1
                        )
                )
           )
           .contentShape(Capsule())
       }
}

#Preview {
    OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.colorPrimary))
}
