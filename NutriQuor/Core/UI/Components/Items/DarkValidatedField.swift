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
    private var isLifted: Bool { isFocused || !text.isEmpty }

    private var borderColor: Color {
        if error != nil { return Color.nqDanger.opacity(0.72) }
        return isFocused ? Color.nqPrimary.opacity(0.62) : Color.white.opacity(0.22)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(error != nil ? Color.nqDanger : isFocused ? Color.nqPrimary : .secondary)
                    .frame(width: 18)
                    .animation(.spring(response: 0.25, dampingFraction: 0.82), value: isFocused)

                ZStack(alignment: .leading) {
                    TextField("", text: $text, prompt: Text(isLifted ? placeholder : title).foregroundStyle(.secondary))
                        .keyboardType(keyboard)
                        .autocapitalization(.none)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.primary)
                        .tint(Color.nqPrimary)
                        .focused($isFocused)
                        .padding(.top, isLifted ? 16 : 0)

                    Text(title)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(error != nil ? Color.nqDanger : isFocused ? Color.nqPrimary : .secondary)
                        .scaleEffect(isLifted ? 1 : 0.92, anchor: .leading)
                        .offset(y: isLifted ? -14 : 0)
                        .opacity(isLifted ? 1 : 0)
                }
                .frame(height: 40)
            }
            .padding(.horizontal, 14)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: .smallRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: .smallRadius, style: .continuous)
                            .stroke(borderColor, lineWidth: 1)
                    )
            )
            .animation(.spring(response: 0.26, dampingFraction: 0.88), value: isLifted)

            HStack(spacing: 4) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 11))
                Text(error ?? " ")
                    .font(.system(size: 11, weight: .medium))
            }
            .foregroundStyle(Color.nqDanger)
            .opacity(error == nil ? 0 : 1)
            .padding(.leading, 2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 14)
        }
        .frame(maxWidth: .infinity)
        .animation(.spring(response: 0.28, dampingFraction: 0.86), value: error)
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
