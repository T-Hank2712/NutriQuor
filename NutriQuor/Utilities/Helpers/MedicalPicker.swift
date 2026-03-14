//
//  MedicalPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/3/26.
//

import SwiftUI

struct MedicalPicker: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var conditions: [Condition]
    
    let allConditions = [
        "Diabetes",
        "Hypertension",
        "Heart Disease",
        "Obesity",
        "Kidney Disease",
        "High Cholesterol"
    ]
    
    var body: some View {
        
        NavigationStack {
            
            List(allConditions, id: \.self) { condition in
                
                Button {
                    
                    conditions.append(
                        Condition(
                            title: condition,
                            status: "Monitored",
                            color: .blue
                        )
                    )
                    
                    dismiss()
                    
                } label: {
                    Text(condition)
                }
                
            }
            .navigationTitle("Select Condition")
        }
    }
}

