//
//  ConditionRow.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct ConditionRow: View {
    
    var title: String
    var color: Color
    var icon: String = "heart.fill"
    var onDelete: (() -> Void)? = nil
    
    @State private var showDeleteAlert = false
    @State private var isHovered = false
    
    var body: some View {
        
        HStack(spacing: 14) {
            
            // Icon
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Title & Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text("Bệnh lý")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Delete Button
            if onDelete != nil {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(color)
                }
                .buttonStyle(.plain)
                .contentShape(Circle())
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [
                            color.opacity(0.08),
                            color.opacity(0.04)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        
        .alert("Xóa bệnh nền?", isPresented: $showDeleteAlert) {
            
            Button("Hủy", role: .cancel) {}
            
            Button("Xóa", role: .destructive) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onDelete?()
                }
            }
            
        } message: {
            Text("Bạn có chắc chắn muốn xóa bệnh nền này khỏi hồ sơ?")
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        
        ConditionRow(
            title: "Đái tháo đường type 2",
            color: Color(red: 1, green: 0.3, blue: 0.3),
            icon: "drop.fill"
        )
        
        ConditionRow(
            title: "Tăng huyết áp",
            color: Color(red: 1, green: 0.6, blue: 0),
            icon: "heart.fill"
        )
        
        ConditionRow(
            title: "Hen suyễn",
            color: Color(red: 0.5, green: 0.8, blue: 1),
            icon: "wind"
        )
        
        ConditionRow(
            title: "Viêm khớp",
            color: Color(red: 0.8, green: 0.3, blue: 0.8),
            icon: "figure.walk"
        )
        
    }
    .padding()
    .background(Color(.systemBackground))
}
