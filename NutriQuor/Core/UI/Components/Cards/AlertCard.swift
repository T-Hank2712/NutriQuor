//
//  InsightCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 30/1/26.
//

import SwiftUI

struct AlertCard: View {
    let color: Color
    let title: String
    let description: String
    var body: some View {
           HStack(spacing: 12) {
               
               Image(systemName: "exclamationmark.triangle.fill")
                   .foregroundColor(color)
               
               VStack(alignment: .leading) {
                   
                   Text(title)
                       .fontWeight(.semibold)
                       .foregroundColor(color)
                   
                   Text(description)
                       .font(.caption)
                       .foregroundColor(color)
               }
           }
           .padding()
           .frame(maxWidth: .infinity, alignment: .leading)
           .background(color.opacity(0.1))
           .cornerRadius(16)
       }
}

#Preview {
    AlertCard(color: .red, title: "Warning", description: "Không giành cho trẻ em dưới 3 tuổi.")
}
