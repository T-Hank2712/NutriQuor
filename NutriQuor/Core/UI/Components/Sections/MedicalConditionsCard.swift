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
        
        BentoCard(accent: Color("InfoBlue"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {
            
            // Header
                HStack {
                    Image(systemName: "cross.case.fill")
                        .foregroundStyle(Color("InfoBlue"))
                
                    Text("Bệnh lý")
                        .fontWeight(.bold)
                
                    Spacer()
                
                    Button {
                        onAdd()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            
                ForEach(diseases) { disease in
                    ConditionRow(
                        title: disease.name,
                        color: Color("InfoBlue").opacity(.opacityMedium)
                    ) {
                        onDelete(disease)
                    }
                }
            }
        }
    }
}

#Preview {
    MedicalConditionsCard(
        diseases: [
            Disease(id: "1", name: "Nuts"),
            Disease(id: "2", name: "Gluten")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
