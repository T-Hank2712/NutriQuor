//
//  IngredientCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct IngredientCard: View {
    var title: String
       var description: String
       var statusColor: Color
       
       var body: some View {
           HStack(alignment: .top, spacing: 12) {
               
               Circle()
                   .fill(statusColor)
                   .frame(width: 10, height: 10)
                   .padding(.top, 6)
               
               VStack(alignment: .leading, spacing: 6) {
                   
                   Text(title)
                       .fontWeight(.semibold)
                   
                   Text(description)
                       .font(.subheadline)
                       .foregroundColor(.gray)
               }
           }
           .padding()
           .frame(maxWidth: .infinity, alignment: .leading)
           .background(Color.white)
           .cornerRadius(.cardRadius)
           
           .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityLight), lineWidth: 1)
           )

           .shadow(color: Color.black.opacity(.opacityLight), radius: 6, x: 0, y: 3)
       }
}

#Preview {
    IngredientCard(title: "Apple", description: "description", statusColor: .green)
}
