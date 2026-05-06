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

    var onSelect: (HealthGoal) -> Void
    
    var body: some View {
        NavigationStack {

            List(viewModel.healthGoals) { healthGoal in
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
            print("LOAD ALLERGIES IN PICKER")
            await viewModel.loadHealthGoals()
        }
    }
}
#Preview {
    GoalPicker(onSelect: { _ in })
}
