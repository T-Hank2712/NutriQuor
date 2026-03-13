//
//  FoundItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct FoundItem: View {
    
    let icon: String
    let title: String
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            Image(systemName: icon)
                .foregroundColor(.green)
            
            Text(title)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(14)
    }
}

#Preview {
    FoundItem(icon: "cup.and.saucer.fill", title: "Diet Sodas")
}
