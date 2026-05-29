//
//  DarkSecureField.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct DarkSecureField: View {
    let title: String
    let placeholder: String
    let icon: String
    @Binding var text: String

    @FocusState private var isFocused: Bool
    @State private var isVisible = false

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
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.3))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.tertiarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
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
        DarkSecureField(
            title: "Mật khẩu",
            placeholder: "Nhập mật khẩu",
            icon: "lock.fill",
            text: .constant("12345678")
        )
        .padding()
    }
}
