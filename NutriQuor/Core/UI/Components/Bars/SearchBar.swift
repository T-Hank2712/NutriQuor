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
                .foregroundColor(.secondary)

            TextField("Search", text: $text)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
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
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(
                    scheme == .dark
                    ? Color.white.opacity(.opacityMedium)
                    : Color.black.opacity(.opacityLight)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(
                    text.isEmpty
                        ? Color.clear
                        : Color("ColorPrimary").opacity(0.4),
                    lineWidth: 1.5
                )
        )
        .shadow(color: .black.opacity(0.1), radius: .cardRadius, y: 3)
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
