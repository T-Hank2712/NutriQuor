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
        }
        .hideBottomBarOnDetail()
    }

    private var profileHeader: some View {
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
                    Text(displayName)
                        .font(.system(size: 21, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                        .lineLimit(2)

                    Text(email.isEmpty ? "Chưa có email" : email)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
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
    }

    private var accountSummaryCard: some View {
        BentoCard(accent: Color("ColorPrimary"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 10) {
                    Image(systemName: "person.text.rectangle.fill")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color("ColorPrimary"))

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
                    .fill(Color("ColorPrimary").opacity(0.10))
                    .frame(width: 36, height: 36)

                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color("ColorPrimary"))
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
