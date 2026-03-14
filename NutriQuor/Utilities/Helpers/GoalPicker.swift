//
//  GoalPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct GoalPicker: View {
    
    let goals: [Goal] = [
        Goal(text: "Lose weight", color: .green),
        Goal(text: "Gain muscle", color: .blue),
        Goal(text: "Eat healthy", color: .orange),
        Goal(text: "Low sugar", color: .red),
        Goal(text: "High protein", color: .purple)
    ]
    
    var onSelect: (Goal) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            List(goals) { goal in
                
                Button {
                    onSelect(goal)
                    dismiss()
                } label: {
                    HStack {
                        Circle()
                            .fill(goal.color)
                            .frame(width: 10)
                        
                        Text(goal.text)
                    }
                }
            }
            .navigationTitle("Select Goal")
        }
    }
}

