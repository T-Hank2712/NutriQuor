//
//  PrimaryGoalsCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct GoalTag: Identifiable {
    let id = UUID()
    let text: String
    let color: Color
}

struct PrimaryGoalsCard: View {
    
    @State private var tags: [GoalTag] = [
        GoalTag(text: "Lose weight", color: .green)
    ]
    
    @State private var showGoalPicker = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "target")
                
                Text("Primary Health Goals")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    showGoalPicker = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundStyle(.green)
                }
            }
            
            HStack {
                ForEach(tags) { tag in
                    Tag(text: tag.text, color: tag.color)
                }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(16)
        .shadow(radius: 2)
        
        .sheet(isPresented: $showGoalPicker) {
            GoalPicker { goal in
                tags.append(goal)
            }
        }
    }
}

#Preview {
    PrimaryGoalsCard()
}
