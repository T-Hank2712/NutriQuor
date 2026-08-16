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
    @State private var showDeleteAlert = false

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var avatar: String = ""
    
    @State private var editFirstName: String = ""
    @State private var editLastName: String = ""

    @StateObject private var viewModel = UserProfileViewModel()


    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 0) {

                    // MARK: - Header
                    BentoCard(accent: Color("ColorPrimary"), style: .plain, padding: 18) {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color("ColorPrimary").opacity(0.12))
                                    .frame(width: 78, height: 78)

                                Text(initials)
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color("ColorPrimary"))
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(firstName) \(lastName)")
                                    .font(.system(size: 21, weight: .bold, design: .rounded))
                                    .foregroundStyle(.primary)
                                    .lineLimit(2)

                                Text("Thành viên gia đình")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.secondary)
                            }

                            Spacer(minLength: 8)

                            Button {
                                editFirstName = firstName
                                editLastName = lastName
                                showEditNameSheet = true
                            } label: {
                                Image(systemName: "pencil")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color("ColorPrimary"))
                                    .frame(width: 38, height: 38)
                                    .background(Color("ColorPrimary").opacity(0.10))
                                    .clipShape(Circle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)

                    // MARK: - Content
                    VStack(spacing: 16) {

                        DangerButton(
                            title: "Xóa thành viên",
                            icon: "trash.fill",
                            color: .red
                        ) {
                            showDeleteAlert = true
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                }
                
            }
            .background(Color("Background"))
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
                                profileId: profile.profileId,
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
        .task {
            firstName = profile.firstName
            lastName = profile.lastName
            avatar = profile.avatar ?? ""
        }
        .alert("Xóa thành viên", isPresented: $showDeleteAlert) {
            Button("Hủy", role: .cancel) { }

            Button("Xóa", role: .destructive) {
                Task {
                    let success = await viewModel.deleteProfile(profileId: profile.profileId)

                    if success {
                        dismiss()
                    }
                }
            }
        } message: {
            Text("Bạn có chắc chắn muốn xóa thành viên này khỏi hồ sơ gia đình không?")
        }
        .hideBottomBarOnDetail()
    }

    // MARK: - Helpers
    private var initials: String {
        let f = firstName.first.map(String.init) ?? ""
        let l = lastName.first.map(String.init) ?? ""
        return (f + l).uppercased()
    }
}

#Preview {
    NavigationStack {
        FamilyMemberProfile(profile: Profile(
            profileId: "",
            firstName: "Thanh",
            lastName: "Lam",
            avatar: nil,
        ))
        .environmentObject(AppState())
    }
}
