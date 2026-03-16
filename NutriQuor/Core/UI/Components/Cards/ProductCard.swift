//
//  ProductCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/3/26.
//

import SwiftUI

struct ProductCard: View {
    var body: some View {
           HStack(spacing: 16) {
               
               RoundedRectangle(cornerRadius: .cardRadius)
                   .fill(Color.green.opacity(.opacityLight))
                   .frame(width: 90, height: 90)
               
               VStack(alignment: .leading, spacing: 6) {
                   
                   Text("Organic Almond Milk")
                       .font(.headline)
                   
                   HStack {
                       Tag(text: "Snack", color: .orange)
                   }
               }
               
               Spacer()
           }
           .background(Color.white)
           .cornerRadius(.cardRadius)
       }}

#Preview {
    ProductCard()
}
