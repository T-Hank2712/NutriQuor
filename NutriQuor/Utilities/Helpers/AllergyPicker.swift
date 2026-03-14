//
//  AllergyPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/3/26.
//

import SwiftUI

struct AllergyPicker: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let allergies = [
        "Nuts",
        "Gluten",
        "Milk",
        "Eggs",
        "Soy",
        "Shellfish"
    ]
    
    var onSelect: (Allergy) -> Void
    
    var body: some View {
        
        NavigationStack {
            
            List(allergies, id: \.self) { allergy in
                
                Button {
                    onSelect(Allergy(text: allergy, color: .red))
                    dismiss()
                } label: {
                    Text(allergy)
                }
                
            }
            .navigationTitle("Select Allergy")
        }
    }
}
