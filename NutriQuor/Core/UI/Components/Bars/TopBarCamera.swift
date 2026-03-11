//
//  TopBarCamera.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct TopBarCamera: View {
    
    @Environment(\.dismiss) private var dismiss   // 👈 thêm dòng này
    
    @State private var selectedMode = "Tôi"
    @State private var showDropdown = false
    
    let modes = ["Tôi","Anh", "Chị", "Ba", "Mẹ"]
    
    var body: some View {
        ZStack {
            
            // Nút X bên trái
            HStack {
                Button {
                    dismiss()   // 👈 quay lại màn trước
                } label: {
                    CircleButton(icon: "xmark")
                }
                
                Spacer()
            }
            
            // Title dropdown ở giữa
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    showDropdown.toggle()
                }
            } label: {
                
                HStack(spacing: 6) {
                    Text(selectedMode.uppercased())
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .bold))
                        .rotationEffect(.degrees(showDropdown ? 180 : 0))
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .stroke(Color.primary, lineWidth: 2)
                )
            }
            .overlay(alignment: .top) {
                
                if showDropdown {
                    DropdownModes(
                        modes: modes,
                        selectedMode: $selectedMode,
                        showDropdown: $showDropdown
                    )
                    .offset(y: 45)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
    }
}
struct DropdownModes: View {
    
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
    TopBarCamera()
}
