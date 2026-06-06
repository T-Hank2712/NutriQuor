//
//  SubmitButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct SubmitButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            HStack(spacing: 12) {
                
                Text(title)
                    .font(.title)
                
                Image(systemName: "arrow.right")
                    .font(.text)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(Color(.heading))
            )
            .shadow(
                color: Color(.colorPrimary).opacity(0.35),
                radius: .cardRadius,
                y: 10
            )
        }
        .padding(.top, 10)
    }
}

#Preview {
    SubmitButton(title: "Sign Up") {
        
    }
}
