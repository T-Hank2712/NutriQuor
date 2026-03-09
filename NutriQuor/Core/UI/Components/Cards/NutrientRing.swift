//
//  NutrientRing.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct NutrientRing: View {
       var percent: Double
        var color: Color
        var label: String
        var value: String
        
        var body: some View {
            
            VStack {
                
                ZStack {
                    
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                        .frame(width: 70)
                    
                    Circle()
                        .trim(from: 0, to: percent/100)
                        .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 70)
                    
                    Text(value)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                Text(label)
                    .font(.title3).bold()
                    .foregroundColor(.gray)
            }.frame(maxWidth: .infinity)
        }
}

#Preview {
    NutrientRing(percent: 70, color: .orange, label: "Protein", value: "70%")
}
