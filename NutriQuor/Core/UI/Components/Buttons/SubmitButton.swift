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
        
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            action()
        } label: {
            
            HStack(spacing: 12) {
                
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 15, weight: .bold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.nqPrimary,
                                Color.nqPrimary.opacity(0.78),
                                Color.nqInfo.opacity(0.86)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                            .stroke(Color.white.opacity(0.28), lineWidth: 1)
                    )
            )
            .shadow(
                color: Color.nqPrimary.opacity(0.22),
                radius: 18,
                y: 9
            )
        }
        .buttonStyle(PressScaleButtonStyle())
        .padding(.top, 10)
    }
}

#Preview {
    SubmitButton(title: "Sign Up") {
        
    }
}
