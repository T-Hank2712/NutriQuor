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
                
                RoundedRectangle(cornerRadius: .smallRadius)
                    .fill(Color(active ? Color(.primary).opacity(.opacityMedium) : Color(.systemGray6)))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(active ? Color(.primary) : .gray)
            }
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(active ? Color(.primary) : Color.clear, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(.opacityLight), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    CategoryCard(icon: "flame", title: "Nutrition", active: false)
}
