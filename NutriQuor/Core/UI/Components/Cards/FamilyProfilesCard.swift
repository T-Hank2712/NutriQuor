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
        BentoCard(accent: Color("ColorPrimary"), style: .plain, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {

                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill")
                        .foregroundStyle(Color("ColorPrimary"))

                    Text("Hồ sơ gia đình")
                        .fontWeight(.bold)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {

                        ForEach(members, id: \.profileId) { member in
                            FullScreenDetailLink {
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
                        }

                        Button(action: onAddMember) {
                            VStack(spacing: 8) {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .foregroundStyle(Color("ColorPrimary").opacity(0.45))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .foregroundStyle(Color("ColorPrimary"))
                                    )

                                Text("Thêm")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
        }
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
                profileId: "",
                firstName: "Thanh",
                lastName: "Lam",
                avatar: nil,
            ),
            Profile(
                profileId: "",
                firstName: "Mai",
                lastName: "Le",
                avatar: nil,
            )
        ],
        onAddMember: {
        }
    )
}
