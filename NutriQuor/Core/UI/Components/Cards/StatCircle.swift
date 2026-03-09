//
//  StatCircle.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 23/2/26.
//

import SwiftUI

struct StatCircle: View {
      var title: String
       var value: String
       var color: Color
       
       var body: some View {
           VStack(spacing: 6) {
               Text(title)
                   .font(.subheadline)
                   .foregroundColor(color)
               
               ZStack {
                   Circle()
                       .stroke(color, lineWidth: 4)
                       .frame(width: 70, height: 70)
                   
                   Text(value)
                       .font(.caption)
                       .foregroundColor(color)
               }
           }
       }
}

#Preview {
    StatCircle(title: "Carbs", value: "30g", color: .blue)
}
