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
    @State private var showEditNameSheet = false
    @State private var showAddFamilySheet = false
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var avatar: String = ""
    
    // Temporary fields used inside the edit sheet
    @State private var editFirstName: String = ""
    @State private var editLastName: String = ""
    
    // Temporary fields for add family member
    @State private var newFamilyFirstName: String = ""
    @State private var newFamilyLastName: String = ""
    @State private var newFamilyAvatar: String = ""
    
    var profileId: String {
        appState.profile?.profileId ?? ""
    }
    
    @StateObject private var viewModel = UserProfileViewModel()
    var body: some View {
        NavigationStack{
            ZStack {
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
                        
                        // Display name + edit button
                        VStack(spacing: 6) {
                            Text("\(lastName) \(firstName)".trimmingCharacters(in: .whitespaces).isEmpty ? "Chưa có tên" : "\(lastName) \(firstName)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Button {
                                editFirstName = firstName
                                editLastName = lastName
                                showEditNameSheet = true
                            } label: {
                                Label("Chỉnh sửa thông tin", systemImage: "pencil")
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 9)
                                    .background(
                                        LinearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .clipShape(Capsule())
                                    .shadow(color: .blue.opacity(0.3), radius: 6, y: 3)
                            }
                            .padding(.top, 6)
                        }

                        colorPrimaryGoalsCard(
                            goals: viewModel.selectedHealthGoals,
                            
                            onAdd: {
                                showHealthGoalPicker = true
                            },
                            
                            onDelete: { goal in
                                
                                Task {
                                    _ = await viewModel.deleteHealthGoal(
                                        profileId: profileId,
                                        healthGoalId: goal.id
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
                                    _ = await viewModel.deleteDisease(
                                        profileId: profileId,
                                        diseaseId: disease.id
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
                                    _ = await viewModel.deleteAllergy(
                                        profileId: profileId,
                                        allergyId: allergy.id
                                    )
                                }
                            }
                        )

                        FamilyProfilesCard(
                            members: viewModel.members,
                            onAddMember: {
                                newFamilyFirstName = ""
                                newFamilyLastName = ""
                                newFamilyAvatar = ""
                                showAddFamilySheet = true
                            }
                        )

                    }
                    .padding()
                    .padding(.bottom, 20)
                }

                // MARK: - Edit Name Popup
                if showEditNameSheet {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showEditNameSheet = false
                        }

                    EditNamePopup(
                        firstName: $editFirstName,
                        lastName: $editLastName,
                        onClose: {
                            showEditNameSheet = false
                        },
                        onSave: {
                            Task {
                                if let updatedProfile = await viewModel.updateUserProfile(
                                    profileId: profileId,
                                    firstName: editFirstName,
                                    lastName: editLastName,
                                    avatar: avatar
                                ) {
                                    await MainActor.run {
                                        appState.profile = updatedProfile
                                        firstName = editFirstName
                                        lastName = editLastName
                                        showEditNameSheet = false
                                    }
                                }
                            }
                        }
                    )
                }

                // MARK: - Add Family Member Popup
                if showAddFamilySheet {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showAddFamilySheet = false
                        }

                    AddFamilyMemberPopup(
                        firstName: $newFamilyFirstName,
                        lastName: $newFamilyLastName,
                        avatar: $newFamilyAvatar,
                        onClose: {
                            showAddFamilySheet = false
                        },
                        onSave: {
                            Task {
                                await viewModel.addUserProfile(
                                    firstName: newFamilyFirstName,
                                    lastName: newFamilyLastName,
                                    avatar: newFamilyAvatar
                                )

                                await viewModel.loadFamilyMembers(profileId: profileId)

                                await MainActor.run {
                                    showAddFamilySheet = false
                                }
                            }
                        }
                    )
                }

            } // end ZStack
        }
        .task {
            firstName = appState.profile?.firstName ?? ""
            lastName = appState.profile?.lastName ?? ""
            email = appState.user?.email ?? ""
            
            
            guard profileId != "" else { return }
            print(profileId)
            
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await viewModel.loadProfileGoals(profileId: profileId)
                }

                group.addTask {
                    await viewModel.loadProfileDiseases(profileId: profileId)
                }

                group.addTask {
                    await viewModel.loadProfileAllergies(profileId: profileId)
                }
                
                group.addTask {
                    await viewModel.loadFamilyMembers(profileId: profileId)
                }
            }
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
