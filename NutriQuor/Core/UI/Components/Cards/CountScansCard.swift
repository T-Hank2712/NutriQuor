//
//  CountScansCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct CountScansCard: View {
    var body: some View {
        VStack(spacing: 8) {
            
            Text("TODAY'S SCANS")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(alignment: .bottom, spacing: 8) {
                
                Text("12")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("+4 vs avg")
                    .font(.caption)
                    .foregroundColor(Color(.colorPrimary))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(.cardRadius)
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityLight), lineWidth: 1)
        )

        .shadow(color: Color.black.opacity(.opacityLight), radius: 1, x: 0, y: 3)
    }
}

#Preview {
    CountScansCard()
}
