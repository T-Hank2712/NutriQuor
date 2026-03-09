//
//  AllergiesCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct AllergiesCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Allergies")
                    .fontWeight(.bold)
            }
            
            HStack {
                AllergyTag(text: "Nuts", color: .red)
                AllergyTag(text: "Gluten", color: .orange)
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(.gray)
                    )
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}

#Preview {
    AllergiesCard()
}
