//
//  ProfileView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState

    @StateObject private var viewModel = UserProfileViewModel()

    @State private var showAllergyPicker = false
    @State private var showEditNameSheet = false

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var avatar = ""

    @State private var editFirstName = ""
    @State private var editLastName = ""

    private var profileId: String {
        appState.profile?.profileId ?? ""
    }

    private var displayName: String {
        let name = "\(lastName) \(firstName)"
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return name.isEmpty ? "Chưa có tên" : name
    }

    private var initials: String {
        let first = firstName.first.map(String.init) ?? ""
        let last = lastName.first.map(String.init) ?? ""
        let value = (last + first).uppercased()
        return value.isEmpty ? "NQ" : value
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 22) {
                        profileHeader
                        accountSummaryCard

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
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                    .padding(.bottom, 28)
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
            .background(Color("Background"))
            .navigationTitle("Hồ sơ")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            syncProfileState()
            guard !profileId.isEmpty else { return }
            await viewModel.loadProfileAllergies(profileId: profileId)
        }
        .sheet(isPresented: $showAllergyPicker) {
            AllergyPicker(
                selectedAllergies: viewModel.selectedAllergies
            ) { allergy in
                Task {
                    await viewModel.addAllergy(profileId: profileId, allergyId: allergy.id)
                    await viewModel.loadProfileAllergies(profileId: profileId)
                }
            }
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color("DeepNavyDark"),
                                Color("DeepNavyMid"),
                                Color("ColorPrimary")
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 180, height: 180)
                    .offset(x: -120, y: -55)

                Circle()
                    .fill(Color("SuccessTeal").opacity(0.20))
                    .frame(width: 140, height: 140)
                    .offset(x: 130, y: 48)

                VStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color("SuccessTeal"),
                                        Color("ColorPrimary")
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 104, height: 104)
                            .shadow(color: Color("ColorPrimary").opacity(0.22), radius: 18, y: 8)

                        Text(initials)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }

                    VStack(spacing: 5) {
                        Text(displayName)
                            .font(.system(size: 23, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)

                        Text(email.isEmpty ? "Chưa có email" : email)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white.opacity(0.68))
                            .lineLimit(1)
                    }

                    Button {
                        editFirstName = firstName
                        editLastName = lastName
                        showEditNameSheet = true
                    } label: {
                        Label("Chỉnh sửa", systemImage: "pencil")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color("DeepNavyDark"))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 9)
                            .background(.white.opacity(0.92))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 18)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 260)
        }
    }

    private var accountSummaryCard: some View {
        BentoCard(accent: Color("InfoBlue"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 10) {
                    Image(systemName: "person.text.rectangle.fill")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color("InfoBlue"))

                    Text("Thông tin tài khoản")
                        .font(.headline.weight(.bold))

                    Spacer()
                }

                VStack(spacing: 12) {
                    profileInfoRow(
                        icon: "person.fill",
                        title: "Họ và tên",
                        value: displayName
                    )

                    Divider()

                    profileInfoRow(
                        icon: "envelope.fill",
                        title: "Email",
                        value: email.isEmpty ? "Chưa có email" : email
                    )
                }
            }
        }
    }

    private func profileInfoRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("InfoBlue").opacity(0.12))
                    .frame(width: 36, height: 36)

                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color("InfoBlue"))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)
            }

            Spacer(minLength: 0)
        }
    }

    private func syncProfileState() {
        firstName = appState.profile?.firstName ?? ""
        lastName = appState.profile?.lastName ?? ""
        email = appState.user?.email ?? ""
        avatar = appState.profile?.avatar ?? ""
    }
}

#Preview {
    ProfileView().environmentObject(AppState())
}
