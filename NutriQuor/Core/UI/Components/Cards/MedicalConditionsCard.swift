//
//  MedicalConditionsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct MedicalConditionsCard: View {
    let diseases: [Disease]

    var onAdd: () -> Void
    var onDelete: (Disease) -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // Header
            HStack {
                Image(systemName: "cross.case.fill")
                    .foregroundStyle(.blue)
                
                Text("Medical Conditions")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    onAdd()
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            // LIST CONDITIONS
            ForEach(diseases) { disease in
                ConditionRow(
                    title: disease.name,
                    color: .colorPrimary.opacity(.opacityMedium)
                ) {
                    onDelete(disease)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color(.colorPrimary))
        )
        .cornerRadius(.cardRadius)
    }
}

#Preview {
    MedicalConditionsCard(
        diseases: [
            Disease(id: 1, name: "Nuts"),
            Disease(id: 2, name: "Gluten")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
