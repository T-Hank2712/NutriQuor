//
//  DarkValidatedSecureField.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct DarkValidatedSecureField: View {
    let title: String
    let placeholder: String
    let icon: String
    @Binding var text: String
    let error: String?

    @FocusState private var isFocused: Bool
    @State private var isVisible = false

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

                Group {
                    if isVisible {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.primary)
                .tint(Color("ColorPrimary"))
                .focused($isFocused)

                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.25))
                }
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

            if let error {
                HStack(spacing: 4) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 11))
                    Text(error)
                        .font(.system(size: 11, weight: .medium))
                }
                .foregroundStyle(Color("ColorPrimary"))
                .padding(.leading, 2)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: error)
    }
}

#Preview {
    ZStack {
        Color("AppDarkBackground").ignoresSafeArea()
        DarkValidatedSecureField(
            title: "Mật khẩu",
            placeholder: "Tối thiểu 8 ký tự",
            icon: "lock.fill",
            text: .constant(""),
            error: "Mật khẩu quá ngắn"
        )
        .padding()
    }
}
