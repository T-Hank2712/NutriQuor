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

        BentoCard(accent: Color("AccentOrange"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {

                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color("AccentOrange"))

                    Text("Dị ứng")
                        .fontWeight(.bold)
                }

                HStack {

                    ForEach(allergies) { allergy in
                        Button {
                            selectedAllergy = allergy
                            showDeleteAlert = true
                        } label: {
                            TagWithXmark(text: allergy.name, color: Color("AccentOrange"))
                        }
                        .buttonStyle(.plain)
                    }

                    Button {
                        onAdd()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Thêm")
                        }
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: .cardRadius)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(Color("AccentOrange").opacity(0.45))
                        )
                    }
                }
            }
        }

        // MARK: - Delete Alert
        .alert("Xóa dị ứng?", isPresented: $showDeleteAlert) {

            Button("Hủy", role: .cancel) {}

            Button("Xóa", role: .destructive) {
                if let allergy = selectedAllergy {
                    onDelete(allergy)
                }
            }

        } message: {
            Text("Bạn có chắc chắn muốn xóa dị ứng này khỏi hồ sơ không?")
        }
    }
}

#Preview {
    AllergiesCard(
        allergies: [
            Allergy(id: "1", name: "Đậu phộng"),
            Allergy(id: "2", name: "Gluten")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
