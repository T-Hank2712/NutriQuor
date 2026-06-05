//
//  ProfileView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var appState: AppState

    @State private var showAllergyPicker = false
    @State private var showDiseasePicker = false
    @State private var showHealthGoalPicker = false
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var avatar: String = ""
    
    var profileId: Int {
        appState.profile?.profileId ?? 0
    }
    
    @StateObject private var viewModel = UserProfileViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                VStack(spacing: 16) {
                    
                    ZStack(alignment: .bottomTrailing) {
                        
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.15),
                                            Color.purple.opacity(0.12)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 130, height: 130)
                                .shadow(color: .black.opacity(0.08), radius: 12, y: 6)
                            
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        
                        // Camera Button
                        Button {
                            print("Change avatar")
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 38, height: 38)
                                
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                        }
                    }
                }
                
                HStack {
                    InputField(
                        title: "First Name",
                        placeholder: "Thanh",
                        icon: "person",
                        text: $firstName
                    )
                    InputField(
                        title: "Last Name",
                        placeholder: "Lam",
                        icon: "person",
                        text: $lastName
                    )
                }
                
                InputField(
                    title: "Email",
                    placeholder: "user@gmail.com",
                    icon: "envelope",
                    text: $email
                )
                .disabled(true)
                .opacity(.opacityStrong)

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

                FamilyProfilesCard(members: appState.profile?.familyMembers ?? [])
                
                SubmitButton(title: "Save Information") {
                    Task {
                        if let updatedProfile = await viewModel.updateUserProfile(
                            profileId: profileId,
                            firstName: firstName,
                            lastName: lastName,
                            avatar: avatar
                        ) {
                            await MainActor.run {
                                appState.profile = updatedProfile
                                dismiss()
                            }
                        }
                    }
                }            }
            .padding()
            .padding(.bottom, 20)
        }
        .task {
            firstName = appState.profile?.firstName ?? ""
            lastName = appState.profile?.lastName ?? ""
            email = appState.user?.email ?? ""
            
            
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
