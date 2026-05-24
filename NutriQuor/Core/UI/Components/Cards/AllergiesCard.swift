//
//  AllergiesCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct AllergiesCard: View {
    let allergies: [Allergy]

    var onAdd: () -> Void
    var onDelete: (Allergy) -> Void

    @State private var showDeleteAlert = false
    @State private var selectedAllergy: Allergy?

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
                        selectedAllergy = allergy
                        showDeleteAlert = true
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

        // MARK: - Delete Alert
        .alert("Remove Allergy?", isPresented: $showDeleteAlert) {

            Button("Cancel", role: .cancel) {}

            Button("Delete", role: .destructive) {
                if let allergy = selectedAllergy {
                    onDelete(allergy)
                }
            }

        } message: {
            Text("Are you sure you want to remove this allergy?")
        }
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
