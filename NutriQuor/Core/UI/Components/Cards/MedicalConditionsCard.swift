//
//  MedicalConditionsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct MedicalConditionsCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "cross.case.fill")
                Text("Medical Conditions")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "pencil")
            }
            
            ConditionRow(
                title: "Type II Diabetes",
                status: "Monitored",
                color: .blue
            )
            
            ConditionRow(
                title: "Hypertension",
                status: "History",
                color: .gray
            )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}

#Preview {
    MedicalConditionsCard()
}
