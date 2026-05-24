//
//  AllergyPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/3/26.
//

import SwiftUI

struct AllergyPicker: View {
    @ObservedObject var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    // Các allergy đã có của user
    let selectedAllergies: [Allergy]

    var onSelect: (Allergy) -> Void

    // Filter bỏ các allergy đã tồn tại
    private var availableAllergies: [Allergy] {
        viewModel.allergyList.filter { allergy in
            !selectedAllergies.contains(where: { $0.id == allergy.id })
        }
    }

    var body: some View {
        NavigationStack {

            List(availableAllergies) { allergy in
                Button {
                    onSelect(allergy)
                    dismiss()
                } label: {
                    Text(allergy.name)
                }
            }
            .navigationTitle("Select Allergies")
        }
        .task {
            await viewModel.loadAllergies()
        }
    }
}

#Preview {
    AllergyPicker(
        selectedAllergies: []
    ) { _ in
        
    }
}
