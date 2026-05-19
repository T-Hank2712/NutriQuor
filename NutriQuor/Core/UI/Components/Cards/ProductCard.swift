//
//  ProductCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/3/26.
//

import SwiftUI

struct ProductCard: View {
    var name: String
    var tags: [String]
    var body: some View {
           HStack(spacing: 16) {
               
               RoundedRectangle(cornerRadius: .cardRadius)
                   .fill(Color.green.opacity(.opacityLight))
                   .frame(width: 90, height: 90)
               
               VStack(alignment: .leading, spacing: 6) {
                   
                   Text(name)
                       .font(.headline)
                       .foregroundStyle(.colorPrimary)
                   
                   HStack {
                       ForEach(tags, id: \.self) { tag in
                           Tag(text: tag, color: .orange)
                       }
                   }
               }
               
               Spacer()
           }
           .background(Color(.systemBackground))
           .cornerRadius(.cardRadius)
       }}

#Preview {
    ProductCard(
        name: "Sữa",
        tags: ["Drink", "Healthy"]
    )
}
