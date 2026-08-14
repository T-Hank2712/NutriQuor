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
    private var isLifted: Bool { isFocused || !text.isEmpty }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(isFocused ? Color.nqPrimary : .secondary)
                    .frame(width: 20)
                    .animation(.spring(response: 0.25, dampingFraction: 0.82), value: isFocused)

                ZStack(alignment: .leading) {
                    Group {
                        if isVisible {
                            TextField("", text: $text, prompt: Text(isLifted ? placeholder : title).foregroundStyle(.secondary))
                        } else {
                            SecureField("", text: $text, prompt: Text(isLifted ? placeholder : title).foregroundStyle(.secondary))
                        }
                    }
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.primary)
                    .tint(Color.nqPrimary)
                    .focused($isFocused)
                    .padding(.top, isLifted ? 16 : 0)

                    Text(title)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(isFocused ? Color.nqPrimary : .secondary)
                        .scaleEffect(isLifted ? 1 : 0.92, anchor: .leading)
                        .offset(y: isLifted ? -14 : 0)
                        .opacity(isLifted ? 1 : 0)
                }
                .frame(height: 40)

                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(PressScaleButtonStyle())
            }
            .padding(.horizontal, 16)
            .frame(height: 58)
            .background(
                RoundedRectangle(cornerRadius: .smallRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: .smallRadius, style: .continuous)
                            .stroke(
                                isFocused ? Color.nqPrimary.opacity(0.62) : Color.nqBorder.opacity(0.9),
                                lineWidth: 1
                            )
                    )
            )
            .animation(.spring(response: 0.26, dampingFraction: 0.88), value: isLifted)
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
