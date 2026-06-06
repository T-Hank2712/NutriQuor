//
//  AddFamilyMemberPopup.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/6/26.
//

import SwiftUI

struct AddFamilyMemberPopup: View {

    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var avatar: String

    var onClose: () -> Void
    var onSave: () -> Void

    var body: some View {

        VStack(spacing: 24) {

            // MARK: Header
            VStack(spacing: 8) {

                Text("Thêm thành viên")
                    .font(.title3.bold())

                Text("Tạo hồ sơ cho người thân trong gia đình")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // MARK: Avatar

            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text(
                    firstName.isEmpty
                    ? "?"
                    : String(firstName.prefix(1))
                )
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)
            }
            .frame(width: 110, height: 110)

            // MARK: Form

            VStack(spacing: 16) {

                DarkInputField(
                    title: "Tên",
                    placeholder: "Ví dụ: Minh",
                    icon: "person.fill",
                    text: $firstName
                )

                DarkInputField(
                    title: "Họ",
                    placeholder: "Ví dụ: Nguyễn",
                    icon: "person.fill",
                    text: $lastName
                )
            }

            // MARK: Buttons

            SubmitButton(
                title: "Thêm thành viên"
            ) {
                onSave()
            }
        }
        .padding(24)
        .frame(maxWidth: 420)
        .background {

            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .overlay {

                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            .primary.opacity(0.06),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 30,
                    y: 12
                )
        }
        .overlay(alignment: .topTrailing) {

            Button {
                onClose()
            } label: {

                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.secondary)
                    .frame(width: 32, height: 32)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(16)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.4).ignoresSafeArea()
        AddFamilyMemberPopup(
            firstName: .constant(""),
            lastName: .constant(""),
            avatar: .constant(""),
            onClose: {},
            onSave: {}
        )
    }
}
