//
//  MedicalPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/3/26.
//

import SwiftUI

struct MedicalPicker: View {
    @ObservedObject var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    // Các disease đã có của user
    let selectedDiseases: [Disease]

    var onSelect: (Disease) -> Void

    // Filter bỏ các disease đã tồn tại
    private var availableDiseases: [Disease] {
        viewModel.diseaseList.filter { disease in
            !selectedDiseases.contains(where: { $0.id == disease.id })
        }
    }

    var body: some View {
        NavigationStack {

            List(availableDiseases) { disease in
                Button {
                    onSelect(disease)
                    dismiss()
                } label: {
                    Text(disease.name).foregroundStyle(Color(.colorPrimary))
                }
            }
            .navigationTitle("Select Diseases")
        }
        .task {
            await viewModel.loadDiseases()
        }
    }
}
#Preview {
    MedicalPicker(
        selectedDiseases: []
    ) { _ in
        
    }
}

