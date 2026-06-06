//
//  ProductCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/3/26.
//

import SwiftUI

struct ProductCard: View {

    let name: String
    let tags: [String]

    var body: some View {

        HStack(spacing: 16) {

            // MARK: Product Image

            ZStack {

                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                .green.opacity(0.15),
                                .green.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: "leaf.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.green)

            }
            .frame(width: 88, height: 88)

            // MARK: Content

            VStack(alignment: .leading, spacing: 10) {

                Text(name)
                    .font(.headline)
                    .lineLimit(2)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {

                        ForEach(tags, id: \.self) { tag in
                            Tag(
                                text: tag,
                                color: .green
                            )
                        }
                    }
                }
            }
        }
        .padding(16)
        .background {

            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .overlay {

                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            .primary.opacity(0.06),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: .black.opacity(0.04),
                    radius: 12,
                    y: 4
                )
        }
    }
}

#Preview {
    ProductCard(
        name: "Sữa",
        tags: ["Drink", "Healthy"]
    )
}
