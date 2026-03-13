//
//  IndexCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct IndexCard: View {
    var body: some View {
        
               VStack(alignment: .leading, spacing: 10) {
                   
                   Text("SAFETY INDEX")
                       .font(.caption)
                       .foregroundColor(.gray)
                   
                   ProgressView(value: 0.7)
                       .tint(.green)
                   
                   HStack {
                       Text("8 SAFE")
                           .font(.caption)
                           .foregroundColor(.green)
                       
                       Spacer()
                       
                       Text("4 AVOID")
                           .font(.caption)
                           .foregroundColor(.red)
                   }
                   
                   Text("70%")
                       .fontWeight(.bold)
               }
               .padding()
               .frame(maxWidth: .infinity, minHeight: 130)
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
    IndexCard()
}
