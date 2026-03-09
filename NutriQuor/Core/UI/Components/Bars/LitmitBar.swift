//
//  LitmitBar.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct LitmitBar: View {
    var title: String
    var value: Double
    var limit: Double
    var unit: String
    var color: Color
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text(title)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text(String(format: "%.1f", value) + unit)
                    .foregroundColor(color)
                
                Text("/ " + String(format: "%.1f", limit) + unit).foregroundStyle(.gray.opacity(0.5)).bold()
            }
            
            
            ZStack(alignment: .leading) {
                
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 12)
                
                Capsule()
                    .fill(color)
                    .frame(width: (value/limit) * 410, height: 12)
            }
            
            

        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 1)
        )
    }
}

#Preview {
    LitmitBar(title: "Fats", value: 75, limit: 150 , unit: "g", color: .blue)
}
