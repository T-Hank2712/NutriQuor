//
//  AllergiesCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct AllergiesCard: View {
    
    @State private var allergies: [Allergy] = [
        Allergy(text: "Nuts", color: .red),
        Allergy(text: "Gluten", color: .orange)
    ]
    
    @State private var showPicker = false
    @State private var selectedAllergy: Allergy? = nil
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundStyle(.orange)
                
                Text("Allergies")
                    .fontWeight(.bold)
            }
            
            HStack {
                
                ForEach(allergies) { allergy in
                    
                    Button {
                        selectedAllergy = allergy
                        showDeleteAlert = true
                    } label: {
                        TagWithXmark(text: allergy.text, color: allergy.color)
                    }
                    .buttonStyle(.plain)
                    
                }
                
                Button {
                    showPicker = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: .cardRadius)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(.gray)
                    )
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityLight), lineWidth: 1)
        )
        .cornerRadius(.cardRadius)
        .shadow(radius: 2)
        
        .sheet(isPresented: $showPicker) {
            AllergyPicker { allergy in
                allergies.append(allergy)
            }
        }
        
        .alert("Remove Allergy?", isPresented: $showDeleteAlert) {
            
            Button("Cancel", role: .cancel) {}
            
            Button("Delete", role: .destructive) {
                if let allergy = selectedAllergy {
                    withAnimation {
                        allergies.removeAll { $0.id == allergy.id }
                    }
                }
            }
            
        } message: {
            Text("Are you sure you want to remove this allergy?")
        }
    }
}

#Preview {
    AllergiesCard()
}
