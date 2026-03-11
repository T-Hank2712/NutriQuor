//
//  ConditionRow.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct ConditionRow: View {
    
    var title: String
    var status: String
    var color: Color
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            Text(status)
                .font(.caption2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .foregroundColor(color)
        }
        .padding(10)
        .background(color.opacity(0.08))
        .cornerRadius(10)
    }
}

#Preview {
    ConditionRow(title: "Tiểu đường", status: "History", color: .blue)
}
