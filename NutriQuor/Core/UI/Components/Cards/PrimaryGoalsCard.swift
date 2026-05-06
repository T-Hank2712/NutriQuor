//
//  PrimaryGoalsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct PrimaryGoalsCard: View {
    
    let goals: [HealthGoal]

    var onAdd: () -> Void
    var onDelete: (HealthGoal) -> Void
    
    @State private var showDeleteAlert = false
    @State private var selectedGoal: HealthGoal?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // Header
            HStack {
                Image(systemName: "target")
                    .foregroundStyle(.green)
                
                Text("Primary Health Goals")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    onAdd()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color(.primary))
                }
            }
            
            // Goals list
            HStack {
                ForEach(goals) { goal in
                    
                    Button {
                        selectedGoal = goal
                        showDeleteAlert = true
                    } label: {
                        Tag(text: goal.name, color: .green)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityMedium), lineWidth: 1)
        )
        .cornerRadius(.cardRadius)
        .shadow(radius: 2)
        
        // Delete confirm
        .alert("Remove Goal?", isPresented: $showDeleteAlert) {
            
            Button("Cancel", role: .cancel) {}
            
            Button("Delete", role: .destructive) {
                if let goal = selectedGoal {
                    onDelete(goal)
                }
            }
            
        } message: {
            Text("Are you sure you want to remove this goal?")
        }
    }
}

#Preview {
    PrimaryGoalsCard(
        goals: [
            HealthGoal(id: 1, name: "Lose Weight"),
            HealthGoal(id: 2, name: "Build Muscle")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
