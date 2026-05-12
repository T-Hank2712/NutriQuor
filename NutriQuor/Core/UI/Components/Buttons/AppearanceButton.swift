//
//  AppearanceButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 5/5/26.
//

import SwiftUI


struct AppearanceButton: View {
    let title: String
    let icon: String
    let mode: AppearanceMode
    @Binding var selected: AppearanceMode
    
    var body: some View {
        Button {
            selected = mode
        } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .foregroundColor(selected == mode ? .white : .black)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(selected == mode ? Color(.primary) : Color.gray.opacity(0.2))
            .cornerRadius(20)
        }
    }
}

#Preview {
    AppearancePreviewWrapper()
}

struct AppearancePreviewWrapper: View {
    @State private var selected: AppearanceMode = .light
    
    var body: some View {
        HStack(spacing: 10) {
            AppearanceButton(
                title: "Light",
                icon: "sun.max",
                mode: .light,
                selected: $selected
            )
            
            AppearanceButton(
                title: "Dark",
                icon: "moon",
                mode: .dark,
                selected: $selected
            )
            
            AppearanceButton(
                title: "System",
                icon: "gear",
                mode: .system,
                selected: $selected
            )
        }
        .padding()
    }
}
