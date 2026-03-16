//
//  PrimaryGoalsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct PrimaryGoalsCard: View {
    
    @State private var tags: [Goal] = [
        Goal(text: "Lose weight", color: .green),
    ]
    
    @State private var showGoalPicker = false
    @State private var selectedGoal: Goal? = nil
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "target")
                    .foregroundStyle(.green)
                
                Text("Primary Health Goals")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    showGoalPicker = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color(.primary))
                }
            }
            
            HStack {
                ForEach(tags) { tag in
                    
                    Button {
                        selectedGoal = tag
                        showDeleteAlert = true
                    } label: {
                        Tag(text: tag.text, color: tag.color)
                    }
                    .buttonStyle(.plain)
                    
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: .smallRadius)
                .stroke(Color.gray.opacity(.opacityMedium), lineWidth: 1)
        )
        .cornerRadius(.cardRadius)
        .shadow(radius: 2)
        
        .sheet(isPresented: $showGoalPicker) {
            GoalPicker { goal in
                tags.append(goal)
            }
        }
        
        .alert("Remove Goal?", isPresented: $showDeleteAlert) {
            
            Button("Cancel", role: .cancel) {}
            
            Button("Delete", role: .destructive) {
                if let goal = selectedGoal {
                    withAnimation {
                        tags.removeAll { $0.id == goal.id }
                    }
                }
            }
            
        } message: {
            Text("Are you sure you want to remove this goal?")
        }
    }
}

#Preview {
    PrimaryGoalsCard()
}
