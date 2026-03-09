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

               Text(title)
                   .font(.system(size: 18))
                   .fontWeight(.medium)
                   .foregroundColor(.primary)

               Spacer()
               
               Image(systemName: icon)
                   .font(.system(size: 24))
           }
           .padding(.horizontal, 16)
           .padding(.vertical, 14)
           .background(
               Capsule()
                .stroke(color.opacity(0.5), lineWidth: 1)
           )
       }
}

#Preview {
    OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.primary))
}
