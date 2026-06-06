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
    var onRemove: (() -> Void)? = nil
    
    @State private var isHovered = false
    
    var body: some View {
        
        HStack(spacing: 6) {
            Text(text)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)

            Image(systemName: "xmark")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(color.opacity(0.7))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .foregroundStyle(color)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [
                            color.opacity(0.12),
                            color.opacity(0.06)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(color.opacity(0.25), lineWidth: 1)
        )
        .scaleEffect(isHovered ? 1.05 : 1.0)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovered = hovering
            }
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        
        HStack(spacing: 8) {
            TagWithXmark(text: "Nuts", color: .red)
            TagWithXmark(text: "Shellfish", color: Color(red: 1, green: 0.6, blue: 0))
            TagWithXmark(text: "Dairy", color: .blue)
        }
        
        HStack(spacing: 8) {
            TagWithXmark(text: "Peanuts", color: Color(red: 0.8, green: 0.4, blue: 0.2))
            TagWithXmark(text: "Eggs", color: Color(red: 1, green: 0.8, blue: 0.2))
        }
        
        HStack(spacing: 8) {
            TagWithXmark(text: "Fish", color: Color(red: 0.2, green: 0.8, blue: 1))
            TagWithXmark(text: "Gluten", color: Color(red: 0.6, green: 0.4, blue: 0.2))
            TagWithXmark(text: "Soy", color: .purple)
        }
        
    }
    .padding()
    .background(Color(.systemBackground))
}
