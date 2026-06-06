//
//  DarkInputField.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct DarkInputField: View {
    let title: String
    let placeholder: String
    let icon: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
                .kerning(0.5)

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(isFocused ? Color("ColorPrimary") : .secondary)
                    .frame(width: 20)
                    .animation(.easeInOut(duration: 0.2), value: isFocused)

                TextField(placeholder, text: $text)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.primary)
                    .tint(Color("ColorPrimary"))
                    .focused($isFocused)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.tertiarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: .smallRadius)
                            .stroke(
                                isFocused ? Color("ColorPrimary") : Color.primary.opacity(0.12),
                                lineWidth: 1.5
                            )
                    )
                    .animation(.easeInOut(duration: 0.2), value: isFocused)
            )
        }
    }
}

#Preview {
    ZStack {
        Color(.systemBackground).ignoresSafeArea()
        DarkInputField(
            title: "Email",
            placeholder: "jane@example.com",
            icon: "envelope.fill",
            text: .constant("jane@example.com"),
            keyboard: .emailAddress
        )
        .padding()
    }
}
