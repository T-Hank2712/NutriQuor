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
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        scheme == .dark
                        ? Color.white.opacity(0.06)
                        : Color.black.opacity(0.04)
                    )
                    .overlay(
                        // Reflection band (gương)
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.55),
                                Color.white.opacity(0.15),
                                Color.clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .opacity(0.35)
                    )
            )
            .overlay(
                // Glass edge
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.5),
                                Color.white.opacity(0.05)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
            .padding(.horizontal)
            .animation(.easeOut(duration: 0.2), value: isFocused)
        }
}


#Preview {
    SearchBar(text: .constant(""))
}
