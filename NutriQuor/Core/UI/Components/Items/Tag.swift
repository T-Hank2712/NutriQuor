//
//  Tag.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/3/26.
//

import SwiftUI

struct Tag: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.headline)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(.opacityLight))
            .foregroundColor(color)
            .cornerRadius(.smallRadius)
    }
}

#Preview {
    Tag(text: "Vegan", color: Color.green)
}
