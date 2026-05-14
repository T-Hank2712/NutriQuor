//
//  InputField.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct InputField: View {
    
    let title: String
    let placeholder: String
    let icon: String
    var isSecure: Bool = false
    
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.title)
                .foregroundStyle(Color.black.opacity(0.85))
            
            HStack(spacing: 14) {
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(Color(hex: "#9C7F87"))
                    .frame(width: 26)
                
                if(isSecure){
                    SecureField(placeholder, text: $text)
                        .font(.body)
                }
                else {
                    TextField(placeholder, text: $text)
                        .font(.text)
                }
            }
            .padding(.horizontal)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(Color(.inputField))
            )
            .overlay(
                RoundedRectangle(cornerRadius: .cardRadius)
                    .stroke(Color(.border), lineWidth: 1)
            )
        }
    }
}

#Preview {
    InputField(
        title: "First Name",
        placeholder: "Jane",
        icon: "person",
        isSecure: false,
        text: .constant("")
    )
}
