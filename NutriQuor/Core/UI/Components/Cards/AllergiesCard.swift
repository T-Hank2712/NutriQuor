//
//  AllergiesCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

import SwiftUI

struct AllergiesCard: View {
    let allergies: [Allergy]

    var onAdd: () -> Void
    var onDelete: (Allergy) -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundStyle(.orange)

                Text("Allergies")
                    .fontWeight(.bold)
            }

            HStack {

                ForEach(allergies) { allergy in
                    Button {
                        onDelete(allergy)
                    } label: {
                        TagWithXmark(text: allergy.name, color: .orange)
                    }
                    .buttonStyle(.plain)
                }

                Button {
                    onAdd()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: .cardRadius)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(.gray)
                    )
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityLight), lineWidth: 1)
        )
        .cornerRadius(.cardRadius)
        .shadow(radius: 2)
    }
}

#Preview {
    AllergiesCard(
        allergies: [
            Allergy(id: 1, name: "Nuts"),
            Allergy(id: 2, name: "Gluten")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
