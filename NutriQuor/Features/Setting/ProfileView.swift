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
                    diseases: viewModel.selectedDiseases,
                    onAdd: {
                        showDiseasePicker = true
                    },
                    onDelete: { disease in
                        
                        Task {
                            
                            await viewModel.deleteDisease(
                                profileId: profileId,
                                diseaseId: disease.id
                            )
                            
                            await viewModel.loadProfileDiseases(
                                profileId: profileId
                            )
                        }
                    }
                )

                // MARK: Allergies
                AllergiesCard(
                    allergies: viewModel.selectedAllergies,
                    onAdd: {
                        showAllergyPicker = true
                    },
                    onDelete: { allergy in
                        
                        Task {
                            
                            await viewModel.deleteAllergy(
                                profileId: profileId,
                                allergyId: allergy.id
                            )
                            
                            await viewModel.loadProfileAllergies(
                                profileId: profileId
                            )
                        }
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
            
            await viewModel.loadProfileDiseases(
                profileId: profileId
            )
            
            await viewModel.loadProfileAllergies(
                profileId: profileId
            )
        }


        // MARK: - Allergy Picker
        .sheet(isPresented: $showAllergyPicker) {
            AllergyPicker(
                selectedAllergies: viewModel.selectedAllergies
            ) { allergy in
                
                Task {
                    
                    await viewModel.addAllergy(
                        profileId: profileId,
                        allergyId: allergy.id
                    )
                    
                    await viewModel.loadProfileAllergies(
                        profileId: profileId
                    )
                }
            }
        }

        // MARK: - Disease Picker
        .sheet(isPresented: $showDiseasePicker) {
            MedicalPicker(
                selectedDiseases: viewModel.selectedDiseases
            ) { disease in
                
                Task {
                    
                    await viewModel.addDisease(
                        profileId: profileId,
                        diseaseId: disease.id
                    )
                    
                    await viewModel.loadProfileDiseases(
                        profileId: profileId
                    )
                }
            }
        }
        
        // MARK: - Health Goal Picker
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
