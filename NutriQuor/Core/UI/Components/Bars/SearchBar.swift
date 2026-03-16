//
//  SearchBar.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import SwiftUI

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

                if !text.isEmpty {
                    Button {
                        text = ""
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
                    .overlay(
                        // Reflection band (gương)
                        LinearGradient(
                            colors: [
                                Color.white.opacity(.opacityMedium),
                                Color.white.opacity(.opacityLight),
                                Color.clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .clipShape(RoundedRectangle(cornerRadius: .cardRadius))
                        .opacity(0.35)
                    )
            )
            .overlay(
                // Glass edge
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(.opacityStrong),
                                Color.white.opacity(.opacityLight)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .black.opacity(.opacityLight), radius: 5, y: 3)
            .animation(.easeOut(duration: 0.2), value: isFocused)
        }
}


#Preview {
    SearchBar(text: .constant(""))
}
