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
    var onDelete: (() -> Void)? = nil
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Spacer()
            
            if onDelete != nil {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 16))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
        .alert("Delete Condition?", isPresented: $showDeleteAlert) {
            
            Button("Cancel", role: .cancel) {}
            
            Button("Delete", role: .destructive) {
                withAnimation {
                    onDelete?()
                }
            }
            
        } message: {
            Text("Are you sure you want to remove this condition?")
        }
    }
}
#Preview {
    VStack(spacing: 12) {
        
        ConditionRow(
            title: "Type II Diabetes",
            color: .blue
        )
        
        ConditionRow(
            title: "Hypertension",
            color: .gray
        )
        
    }
    .padding()
}
