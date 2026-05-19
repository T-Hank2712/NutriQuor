//
//  IndexCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct IndexCard: View {
    var body: some View {
        
               VStack(alignment: .leading, spacing: 10) {
                   
                   Text("SAFETY INDEX")
                       .font(.caption)
                       .foregroundColor(.gray)
                   
                   ProgressView(value: 0.7)
                       .tint(Color(.colorPrimary))
                   
                   HStack {
                       Text("8 SAFE")
                           .font(.caption)
                           .foregroundColor(Color(.colorPrimary))
                       
                       Spacer()
                       
                       Text("4 AVOID")
                           .font(.caption)
                           .foregroundColor(Color(.badHealth))
                   }
                   
                   Text("70%")
                       .fontWeight(.bold)
               }
               .padding()
               .frame(maxWidth: .infinity, minHeight: 130)
               .background(Color(.systemBackground))
               .cornerRadius(.cardRadius)
               .overlay(
                RoundedRectangle(cornerRadius: .cardRadius)
                    .stroke(Color.gray.opacity(.opacityLight), lineWidth: 1)
               )

               .shadow(color: Color.black.opacity(.opacityLight), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    IndexCard()
}
