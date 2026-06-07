//
//  FamilyProfileCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct FamilyProfilesCard: View {

    let members: [Profile]
    var onAddMember: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(spacing: 8) {
                Image(systemName: "person.2.fill")
                    .foregroundStyle(Color("ColorPrimary"))

                Text("Family Profiles")
                    .fontWeight(.bold)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {

                    ForEach(members, id: \.profileId) { member in
                        NavigationLink {
                            FamilyMemberProfile(profile: member)
                        } label: {
                            VStack(spacing: 8) {

                                ZStack {
                                    Circle()
                                        .fill(Color("ColorPrimary").opacity(0.12))
                                        .frame(width: 56, height: 56)

                                    Text(initials(for: member))
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color("ColorPrimary"))
                                }

                                Text("\(member.lastName) \(member.firstName)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                            }
                        }
                        .buttonStyle(.plain)
                    }

                    Button(action: onAddMember) {
                        VStack(spacing: 8) {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Image(systemName: "plus")
                                )

                            Text("Add")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color("ColorPrimary").opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(.cardRadius)
    }

    private func initials(for profile: Profile) -> String {
        let f = profile.firstName.first.map(String.init) ?? ""
        let l = profile.lastName.first.map(String.init) ?? ""
        return (f + l).uppercased()
    }
}

#Preview {
    FamilyProfilesCard(
        members: [
            Profile(
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
            ),
            Profile(
                profileId: 2,
                userId: 1,
                firstName: "Mai",
                lastName: "Le",
                avatar: nil,
                healthGoals: [],
                diseases: [],
                allergies: [],
                familyMembers: [],
                parentProfileId: nil
            )
        ],
        onAddMember: {
            print("Add member tapped")
        }
    )
}
