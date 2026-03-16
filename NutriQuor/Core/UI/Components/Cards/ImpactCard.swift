//
//  ImpactCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct ImpactCard: View {
    
    let icon: String
    let title: String
    let text: String
    let color: Color
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: icon)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .fontWeight(.semibold)
                
                Text(text)
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(.opacityLight))
        .cornerRadius(.cardRadius)
    }
}

#Preview {
    ImpactCard(icon: "Weight Loss", title: "Weight Loss", text: "Chẳng có gì cả", color: .gray)
}
