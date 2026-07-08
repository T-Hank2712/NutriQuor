//
//  EditNamePopup.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/6/26.
//


import SwiftUI
struct EditNamePopup: View {

    @Binding var firstName: String
    @Binding var lastName: String

    var onClose: () -> Void
    var onSave: () -> Void

    var body: some View {
        VStack(spacing: 24) {

            // MARK: Header
            VStack(spacing: 12) {

                ZStack {
                    Circle()
                        .fill(Color("ColorPrimary").opacity(0.12))
                        .frame(width: 70, height: 70)

                    Image(systemName: "person.text.rectangle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color("ColorPrimary"))
                }

                VStack(spacing: 4) {
                    Text("Chỉnh sửa thông tin")
                        .font(.title3.bold())

                    Text("Cập nhật họ và tên hiển thị của bạn")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            // MARK: Form
            VStack(spacing: 16) {

                DarkInputField(
                    title: "Tên",
                    placeholder: "Nhập tên",
                    icon: "person.fill",
                    text: $firstName
                )

                DarkInputField(
                    title: "Họ",
                    placeholder: "Nhập họ",
                    icon: "person.fill",
                    text: $lastName
                )
            }

            // MARK: Actions
            SubmitButton(
                title: "Lưu thay đổi"
            ) {
                onSave()
            }
        }
        .padding(24)
        .frame(maxWidth: 420)
        .background {
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color(.systemBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(
                            Color.primary.opacity(0.08),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 18,
                    y: 8
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
        EditNamePopup(
            firstName: .constant("Thanh"),
            lastName: .constant("Lam"),
            onClose: {},
            onSave: {}
        )
    }
}
