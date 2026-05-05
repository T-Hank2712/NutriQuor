//
//  AllergyPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/3/26.
//

import SwiftUI

struct AllergyPicker: View {
    @StateObject var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    var onSelect: (Allergy) -> Void

    var body: some View {
        NavigationStack {

            List(viewModel.allergyList) { allergy in
                Button {
                    onSelect(allergy)
                    dismiss()
                } label: {
                    Text(allergy.name)
                }
            }
            .navigationTitle("Select Allergy")
        }
        .task {
            print("LOAD ALLERGIES IN PICKER")
            await viewModel.loadAllergies()
        }
    }
}

#Preview {
    AllergyPicker(onSelect: { _ in })
}
