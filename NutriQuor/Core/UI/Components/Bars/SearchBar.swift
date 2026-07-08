//
//  SearchBar.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import SwiftUI

// SearchBar.swift - thêm binding isFocused hoặc dùng text để detect
struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(isFocused ? Color.nqPrimary : .secondary)

            TextField("Search", text: $text)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .tint(Color.nqPrimary)
                .onSubmit {
                    isFocused = false
                }

            if !text.isEmpty {
                Button {
                    text = ""
                    isFocused = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PressScaleButtonStyle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(scheme == .dark ? 0.08 : 0.34),
                            Color.white.opacity(scheme == .dark ? 0.02 : 0.10)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                .stroke(
                    !isFocused && text.isEmpty
                        ? Color.white.opacity(scheme == .dark ? 0.12 : 0.26)
                        : Color.nqPrimary.opacity(0.44),
                    lineWidth: 1
                )
        )
        .shadow(color: .black.opacity(scheme == .dark ? 0.28 : 0.06), radius: 16, y: 8)
        .animation(.spring(response: 0.28, dampingFraction: 0.82), value: text.isEmpty)
        .animation(.spring(response: 0.28, dampingFraction: 0.82), value: isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
