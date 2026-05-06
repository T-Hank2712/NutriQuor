//
//  MedicalPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/3/26.
//

import SwiftUI

struct MedicalPicker: View {
    @StateObject var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    var onSelect: (Disease) -> Void
    
    var body: some View {
        NavigationStack {

            List(viewModel.diseaseList) { allergy in
                Button {
                    onSelect(allergy)
                    dismiss()
                } label: {
                    Text(allergy.name)
                }
            }
            .navigationTitle("Select Disease")
        }
        .task {
            print("LOAD DISEASE IN PICKER")
            await viewModel.loadDiseases()
        }
    }
}
#Preview {
    MedicalPicker(onSelect: { _ in })
}

