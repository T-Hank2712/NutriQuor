//
//  colorPrimaryGoalsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct colorPrimaryGoalsCard: View {
    
    let goals: [HealthGoal]

    var onAdd: () -> Void
    var onDelete: (HealthGoal) -> Void
    
    @State private var showDeleteAlert = false
    @State private var selectedGoal: HealthGoal?
    
    var body: some View {
        
        BentoCard(accent: Color("SuccessTeal"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {
            
                HStack {
                    Image(systemName: "target")
                        .foregroundStyle(Color("SuccessTeal"))
                
                    Text("Mục tiêu sức khoẻ")
                        .fontWeight(.bold)
                
                    Spacer()
                
                    Button {
                        onAdd()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(Color("ColorPrimary"))
                    }
                }
            
                HStack {
                    ForEach(goals) { goal in
                    
                        Button {
                            selectedGoal = goal
                            showDeleteAlert = true
                        } label: {
                            Tag(text: goal.name, color: Color("SuccessTeal"))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        
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
    colorPrimaryGoalsCard(
        goals: [
            HealthGoal(id: "1", name: "Lose Weight"),
            HealthGoal(id: "2", name: "Build Muscle")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
