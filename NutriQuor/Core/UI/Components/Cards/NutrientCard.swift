//
//  NutrientCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 7/3/26.
//

import SwiftUI

struct NutrientCard: View {
      var title: String
       var value: String
       var color: Color
       var icon: String
       var body: some View {
           VStack(spacing: 8) {
               
               Image(systemName: icon).foregroundStyle(color)
               
               Text(title)
                   .font(.caption)
                   .foregroundColor(.gray)
               
               Text(value)
                   .font(.headline)
           }
           .frame(maxWidth: .infinity)
           .padding()
           .background(Color.white)
           .cornerRadius(.cardRadius)
           .shadow(color: Color.black.opacity(.opacityLight), radius: 6, x: 0, y: 3)
       }
}

#Preview {
    NutrientCard(title: "PROTEIN", value: "8g", color: .blue, icon: "drop.fill")
}
