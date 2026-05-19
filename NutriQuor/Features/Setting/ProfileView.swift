//
//  ProfileView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ProfileView: View {

    @State private var showAllergyPicker = false
    @State private var showDiseasePicker = false
    @State private var showHealthGoalPicker = false
    
    @State private var allergies: [Allergy] = []
    @State private var diseases: [Disease] = []
    @State private var healthGoals: [HealthGoal] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                colorPrimaryGoalsCard(
                    goals: healthGoals,
                    onAdd: { showHealthGoalPicker = true},
                    onDelete: { healthGoal in
                        healthGoals.removeAll { $0.id == healthGoal.id } }
                )

                // MARK: Medical Conditions
                MedicalConditionsCard(
                    diseases: diseases,
                    onAdd: {
                        showDiseasePicker = true
                    },
                    onDelete: { disease in
                        diseases.removeAll { $0.id == disease.id }
                    }
                )

                // MARK: Allergies
                AllergiesCard(
                    allergies: allergies,
                    onAdd: {
                        showAllergyPicker = true
                    },
                    onDelete: { allergy in
                        allergies.removeAll { $0.id == allergy.id }
                    }
                )

                FamilyProfilesCard()
            }
            .padding()
        }

        // MARK: Allergy Picker
        .sheet(isPresented: $showAllergyPicker) {
            AllergyPicker { allergy in
                allergies.append(allergy)
                showAllergyPicker = false
            }
        }

        // MARK: Disease Picker
        .sheet(isPresented: $showDiseasePicker) {
            MedicalPicker { disease in
                diseases.append(disease)
                showDiseasePicker = false
            }
        }
        
        // MARK: Health Goal Picker
        .sheet(isPresented: $showHealthGoalPicker) {
            GoalPicker { healthGoal in
                healthGoals.append(healthGoal)
                showHealthGoalPicker = false
            }
        }
    }
}

#Preview {
    ProfileView()
}
