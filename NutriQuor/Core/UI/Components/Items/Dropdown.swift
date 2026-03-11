//
//  Dropdown.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 11/3/26.
//

import SwiftUI

struct Dropdown: View {
    let modes: [String]
    
    @Binding var selectedMode: String
    @Binding var showDropdown: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ForEach(modes, id: \.self) { mode in
                
                Button {
                    withAnimation(.spring()) {
                        selectedMode = mode
                        showDropdown = false
                    }
                } label: {
                    
                    HStack {
                        
                        Text(mode)
                            .fontWeight(selectedMode == mode ? .bold : .regular)
                        
                        Spacer()
                        
                        if selectedMode == mode {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .foregroundColor(.primary)
                }
                
                if mode != modes.last {
                    Divider()
                }
            }
        }
        .frame(width: 180)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.2))
        )
        .shadow(radius: 10)
    }
}

#Preview {
    Dropdown(
        modes: ["Photo", "Label Scan", "Barcode"],
        selectedMode: .constant("Photo"),
        showDropdown: .constant(true)
    )
    .padding()
}
