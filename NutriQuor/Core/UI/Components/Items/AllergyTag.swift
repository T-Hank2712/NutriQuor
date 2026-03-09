//
//  AllergyTag.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct AllergyTag: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        
        HStack {
            Text(text)
            Image(systemName: "xmark").foregroundStyle(.gray)
        }
        .font(.title3)
        .padding(8)
        .background(color.opacity(0.15))
        .foregroundColor(color)
        .cornerRadius(10)
    }
}

#Preview {
    AllergyTag(text: "Nuts", color: .red)
}
