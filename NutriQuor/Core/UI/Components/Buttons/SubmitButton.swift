//
//  SubmitButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct SubmitButton: View {
    let title: String
    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: 12) {
                
                Text(title)
                    .font(.heading3)
                
                Image(systemName: "arrow.right")
                    .font(.text)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 65)
            .background(
                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(Color(.heading))
            )
            .shadow(
                color: Color(.primary).opacity(0.35),
                radius: .cardRadius,
                y: 10
            )
        }
        .padding(.top, 10)
    }
}

#Preview {
    SubmitButton(title: "Sign Up")
}
