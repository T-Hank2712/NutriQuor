//
//  TagWithXmark.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct TagWithXmark: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        
        HStack {
            Text(text)
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
            Image(systemName: "xmark").foregroundStyle(.gray)
        }
        .font(.title3)
        .padding(8)
        .background(color.opacity(.opacityLight))
        .foregroundColor(color)
        .cornerRadius(.smallRadius)
    }
}

#Preview {
    TagWithXmark(text: "Nuts", color: .red)
}
