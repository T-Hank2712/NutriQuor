//
//  MedicalConditionsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct MedicalConditionsCard: View {
    
    @State private var showConditionList = false
    
    @State private var conditions: [Condition] = [
        Condition(title: "Type II Diabetes", status: "Monitored", color: .blue)
    ]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "cross.case.fill")
                    .foregroundStyle(.blue)
                
                Text("Medical Conditions")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    showConditionList = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ForEach(conditions) { condition in
                ConditionRow(
                    title: condition.title,
                    color: condition.color
                ) {
                    conditions.removeAll { $0.id == condition.id }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.5))
        )
        .shadow(radius: 2)
        
        .sheet(isPresented: $showConditionList) {
            MedicalPicker(conditions: $conditions)
        }
    }
}

#Preview {
    MedicalConditionsCard()
}
