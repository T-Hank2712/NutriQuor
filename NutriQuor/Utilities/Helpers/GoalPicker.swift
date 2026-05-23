//
//  GoalPicker.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct GoalPicker: View {
    
    @StateObject var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    // Các goal đã có của user
    let selectedGoals: [HealthGoal]

    var onSelect: (HealthGoal) -> Void

    // Filter bỏ các goal đã tồn tại
    private var availableGoals: [HealthGoal] {
        viewModel.healthGoals.filter { goal in
            !selectedGoals.contains(where: { $0.id == goal.id })
        }
    }

    var body: some View {
        NavigationStack {

            List(availableGoals) { healthGoal in
                Button {
                    onSelect(healthGoal)
                    dismiss()
                } label: {
                    Text(healthGoal.name)
                }
            }
            .navigationTitle("Select Health Goal")
        }
        .task {
            await viewModel.loadHealthGoals()
        }
    }
}

#Preview {
    GoalPicker(
        selectedGoals: []
    ) { _ in
        
    }
}
