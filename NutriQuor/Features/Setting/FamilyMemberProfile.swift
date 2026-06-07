//
//  FamilyMemberProfile.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/5/26.
//

import SwiftUI

struct FamilyMemberProfile: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState

    let profile: Profile
    
    @State private var showEditNameSheet = false

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var avatar: String = ""
    
    @State private var editFirstName: String = ""
    @State private var editLastName: String = ""

    @State private var showAllergyPicker = false
    @State private var showDiseasePicker = false
    @State private var showHealthGoalPicker = false

    @StateObject private var viewModel = UserProfileViewModel()

    var profileId: Int { profile.profileId }

    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 0) {

                    // MARK: - Hero Header
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            colors: [
                                Color("DeepNavyDark"),
                                Color("DeepNavyMid"),
                                Color("DeepNavy")
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 300)
                        .ignoresSafeArea(edges: .top)

                        // Decorative circles
                        Circle()
                            .fill(Color.white.opacity(0.03))
                            .frame(width: 200, height: 200)
                            .offset(x: -80, y: -20)

                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 150, height: 150)
                            .offset(x: 100, y: 30)

                        VStack(spacing: 12) {
                            // Avatar
                            ZStack(alignment: .bottomTrailing) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color("AccentPink").opacity(0.8),
                                                    Color("DeepNavy").opacity(0.9)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 100, height: 100)
                                        .shadow(color: Color("AccentPink").opacity(0.4), radius: 20, y: 8)

                                    Text(initials)
                                        .font(.system(size: 36, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                }

                                Button {
                                    print("Change avatar")
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color("AccentPink"))
                                            .frame(width: 30, height: 30)
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundStyle(.white)
                                    }
                                    .shadow(color: Color("AccentPink").opacity(0.5), radius: 8, y: 3)
                                }
                            }
                            
                            Text("\(firstName) \(lastName)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.bottom, 16)
                            
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
                            }.padding(.bottom, 20)
                        }.padding(.top, 70)
                    }

                    // MARK: - Content
                    VStack(spacing: 16) {

                        // Health Goals
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel(text: "MỤC TIÊU SỨC KHOẺ")

                            colorPrimaryGoalsCard(
                                goals: viewModel.selectedHealthGoals,
                                onAdd: { showHealthGoalPicker = true },
                                onDelete: { goal in
                                    Task {
                                        await viewModel.deleteHealthGoal(profileId: profileId, healthGoalId: goal.id)
                                        await viewModel.loadProfileGoals(profileId: profileId)
                                    }
                                }
                            )
                        }

                        Divider().opacity(0.2)

                        // Diseases
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel(text: "BỆNH LÝ")

                            MedicalConditionsCard(
                                diseases: viewModel.selectedDiseases,
                                onAdd: { showDiseasePicker = true },
                                onDelete: { disease in
                                    Task {
                                        await viewModel.deleteDisease(profileId: profileId, diseaseId: disease.id)
                                        await viewModel.loadProfileDiseases(profileId: profileId)
                                    }
                                }
                            )
                        }

                        Divider().opacity(0.2)

                        // Allergies
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel(text: "DỊ ỨNG")

                            AllergiesCard(
                                allergies: viewModel.selectedAllergies,
                                onAdd: { showAllergyPicker = true },
                                onDelete: { allergy in
                                    Task {
                                        await viewModel.deleteAllergy(profileId: profileId, allergyId: allergy.id)
                                        await viewModel.loadProfileAllergies(profileId: profileId)
                                    }
                                }
                            )
                        }
                        
                        DangerButton(
                            title: "Xóa thành viên",
                            icon: "trash.fill",
                            color: Color("AccentPink")
                        ) {
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                }
                
            }
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
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Quay lại")
                            .font(.system(size: 15, weight: .medium))
                    }
                    .foregroundStyle(.white)
                }
            }
        }
        .task {
            firstName = profile.firstName
            lastName = profile.lastName
            avatar = profile.avatar ?? ""

            await viewModel.loadProfileGoals(profileId: profileId)
            await viewModel.loadProfileDiseases(profileId: profileId)
            await viewModel.loadProfileAllergies(profileId: profileId)
        }

        // MARK: - Sheets
        .sheet(isPresented: $showAllergyPicker) {
            AllergyPicker(selectedAllergies: viewModel.selectedAllergies) { allergy in
                Task {
                    await viewModel.addAllergy(profileId: profileId, allergyId: allergy.id)
                    await viewModel.loadProfileAllergies(profileId: profileId)
                }
            }
        }
        .sheet(isPresented: $showDiseasePicker) {
            MedicalPicker(selectedDiseases: viewModel.selectedDiseases) { disease in
                Task {
                    await viewModel.addDisease(profileId: profileId, diseaseId: disease.id)
                    await viewModel.loadProfileDiseases(profileId: profileId)
                }
            }
        }
        .sheet(isPresented: $showHealthGoalPicker) {
            GoalPicker(selectedGoals: viewModel.selectedHealthGoals) { goal in
                Task {
                    await viewModel.addHealthGoal(profileId: profileId, healthGoalId: goal.id)
                    await viewModel.loadProfileGoals(profileId: profileId)
                }
            }
        }
    }

    // MARK: - Helpers
    private var initials: String {
        let f = firstName.first.map(String.init) ?? ""
        let l = lastName.first.map(String.init) ?? ""
        return (f + l).uppercased()
    }
}

// MARK: - Family Input Field
private struct FamilyInputField: View {
    let title: String
    let placeholder: String
    let icon: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)

            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AccentPink"))
                    .frame(width: 20)

                TextField(placeholder, text: $text)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("AccentPink").opacity(0.15), lineWidth: 1)
                    )
            )
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        FamilyMemberProfile(profile: Profile(
            profileId: 1,
            userId: 1,
            firstName: "Thanh",
            lastName: "Lam",
            avatar: nil,
            healthGoals: [],
            diseases: [],
            allergies: [],
            familyMembers: [],
            parentProfileId: nil
        ))
        .environmentObject(AppState())
    }
}
