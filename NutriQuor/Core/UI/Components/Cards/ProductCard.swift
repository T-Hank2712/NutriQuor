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

                RoundedRectangle(cornerRadius: .cardRadius)
                    .fill(Color("ColorPrimary").opacity(0.08))

                Image(systemName: "leaf.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(Color("ColorPrimary"))

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
                                color: Color("ColorPrimary")
                            )
                        }
                    }
                }
            }
        }
        .padding(16)
        .background {

            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color(.systemBackground))
                .overlay {

                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(
                            .primary.opacity(0.06),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: .black.opacity(0.04),
                    radius: 8,
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
