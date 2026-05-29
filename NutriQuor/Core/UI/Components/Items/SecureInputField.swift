//
//  SecureInputField.swift
//  NutriQuor
//

import SwiftUI

struct SecureInputField: View {
    
    let title: String
    let placeholder: String
    let icon: String
    
    @Binding var text: String
    
    @State private var isSecure = true
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.title)
                .foregroundStyle(Color.colorPrimary.opacity(0.85))
            
            HStack(spacing: 14) {
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(Color("MutedMauve"))
                    .frame(width: 26)
                
                Group {
                    
                    if isSecure {
                        
                        SecureField(placeholder, text: $text).textContentType(.oneTimeCode)
                        
                    } else {
                        
                        TextField(placeholder, text: $text)
                    }
                }
                .font(.text)
                
                Button {
                    isSecure.toggle()
                } label: {
                    
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
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
    SecureInputField(
        title: "First Name",
        placeholder: "Jane",
        icon: "person",
        text: .constant("")
    )
}
