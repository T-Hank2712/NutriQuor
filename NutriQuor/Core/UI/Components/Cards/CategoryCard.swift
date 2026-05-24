//
//  SwiftUIView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct CategoryCard: View {
    
    let icon: String
    let title: String
    var active: Bool = false
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(Color(active ? Color(.colorPrimary).opacity(.opacityMedium) : Color(.systemGray6)))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(active ? Color(.colorPrimary) : .gray)
            }
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(.cardRadius)
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(active ? Color(.colorPrimary) : Color.clear, lineWidth: 1)
        )
        .shadow(radius: 1)
    }
}

#Preview {
    CategoryCard(icon: "flame", title: "Nutrition", active: false)
}
