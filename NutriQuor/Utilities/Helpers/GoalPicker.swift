//
//  GoalPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct GoalPicker: View {
    
    let goals: [GoalTag] = [
        GoalTag(text: "Lose weight", color: .green),
        GoalTag(text: "Gain muscle", color: .blue),
        GoalTag(text: "Eat healthy", color: .orange),
        GoalTag(text: "Low sugar", color: .red),
        GoalTag(text: "High protein", color: .purple)
    ]
    
    var onSelect: (GoalTag) -> Void
    
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

