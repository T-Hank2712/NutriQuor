//
//  ProfileView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var appState: AppState

    @State private var showAllergyPicker = false
    @State private var showDiseasePicker = false
    @State private var showHealthGoalPicker = false
    
    @State private var allergies: [Allergy] = []
    @State private var diseases: [Disease] = []
    @State private var healthGoals: [HealthGoal] = []
    
    var profileId: Int {
        appState.profile?.profileId ?? 0
    }
    
    @StateObject private var viewModel = UserProfileViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                colorPrimaryGoalsCard(
                    goals: viewModel.selectedHealthGoals,
                    
                    onAdd: {
                        showHealthGoalPicker = true
                    },
                    
                    onDelete: { goal in
                        
                        Task {
                            
                            await viewModel.deleteHealthGoal(
                                profileId: profileId,
                                healthGoalId: goal.id
                            )
                            
                            await viewModel.loadProfileGoals(
                                profileId: profileId
                            )
                        }
                    }
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
        .task {
            
            guard profileId != 0 else { return }
            print(profileId)
            await viewModel.loadProfileGoals(
                profileId: profileId
            )
            
//            await viewModel.loadProfileDiseases(
//                profileId: profileId
//            )
//            
//            await viewModel.loadProfileAllergies(
//                profileId: profileId
//            )
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
            
            GoalPicker(
                selectedGoals: viewModel.selectedHealthGoals
            ) { goal in
                
                Task {
                    
                    await viewModel.addHealthGoal(
                        profileId: profileId,
                        healthGoalId: goal.id
                    )
                    
                    await viewModel.loadProfileGoals(
                        profileId: profileId
                    )
                }
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(AppState())
}
