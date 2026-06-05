//
//  DarkValidatedField.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct DarkValidatedField: View {
    let title: String
    let placeholder: String
    let icon: String
    @Binding var text: String
    let error: String?
    var keyboard: UIKeyboardType = .default

    @FocusState private var isFocused: Bool

    private var borderColor: Color {
        if let _ = error { return Color("ColorPrimary") }
        return isFocused ? Color("ColorPrimary") : Color.primary.opacity(0.12)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
                .kerning(0.5)

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(error != nil ? Color("ColorPrimary") : isFocused ? Color("ColorPrimary") : .secondary)
                    .frame(width: 18)
                    .animation(.easeInOut(duration: 0.2), value: isFocused)

                TextField(placeholder, text: $text)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.primary)
                    .tint(Color("ColorPrimary"))
                    .focused($isFocused)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color(.tertiarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(borderColor, lineWidth: 1.5)
                    )
                    .animation(.easeInOut(duration: 0.2), value: isFocused)
            )

            HStack(spacing: 4) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 11))
                Text(error ?? " ")
                    .font(.system(size: 11, weight: .medium))
            }
            .foregroundStyle(Color("ColorPrimary"))
            .opacity(error == nil ? 0 : 1)
            .padding(.leading, 2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 14)
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut(duration: 0.2), value: error)
    }
}

#Preview {
    ZStack {
        Color("AppDarkBackground").ignoresSafeArea()
        DarkValidatedField(
            title: "Email",
            placeholder: "jane@example.com",
            icon: "envelope.fill",
            text: .constant(""),
            error: "Email không hợp lệ",
            keyboard: .emailAddress
        )
        .padding()
    }
}
