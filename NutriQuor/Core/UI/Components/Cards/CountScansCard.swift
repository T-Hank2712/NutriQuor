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
                    .foregroundColor(.green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
             .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )

        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    CountScansCard()
}
