//
//  RegisterView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct RegisterView: View {

    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var appState: AppState
    @State private var showSuccessAlert = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color("Background"),
                    Color.nqPrimary.opacity(0.10),
                    Color.nqInfo.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .frame(width: 78, height: 78)
                                .overlay(
                                    RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                                        .stroke(Color.white.opacity(0.28), lineWidth: 1)
                                )
                                .shadow(color: Color.nqPrimary.opacity(0.18), radius: 18, y: 8)

                            Image(systemName: "heart.fill")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.nqPrimary, Color.nqInfo],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }

                        VStack(spacing: 6) {
                            Text("Tạo tài khoản")
                                .font(.system(size: 28, weight: .black, design: .rounded))
                                .foregroundStyle(.primary)

                            Text("Bắt đầu hành trình dinh dưỡng của bạn")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 52)

                    VStack(spacing: 20) {

                        // Name row
                        HStack(spacing: 12) {
                            DarkValidatedField(
                                title: "Tên",
                                placeholder: "An",
                                icon: "person.fill",
                                text: $viewModel.firstName.value,
                                error: viewModel.firstName.error
                            )
                            DarkValidatedField(
                                title: "Họ",
                                placeholder: "Nguyễn",
                                icon: "person.fill",
                                text: $viewModel.lastName.value,
                                error: viewModel.lastName.error
                            )
                        }

                        DarkValidatedField(
                            title: "Email",
                            placeholder: "ten@example.com",
                            icon: "envelope.fill",
                            text: $viewModel.email.value,
                            error: viewModel.email.error,
                            keyboard: .emailAddress
                        )

                        DarkValidatedSecureField(
                            title: "Mật khẩu",
                            placeholder: "Tối thiểu 8 ký tự",
                            icon: "lock.fill",
                            text: $viewModel.password.value,
                            error: viewModel.password.error
                        )

                        DarkValidatedSecureField(
                            title: "Xác nhận mật khẩu",
                            placeholder: "Nhập lại mật khẩu",
                            icon: "lock.shield.fill",
                            text: $viewModel.confirmPassword.value,
                            error: viewModel.confirmPassword.error
                        )

                        // Global error
                        if let error = viewModel.errorMessage {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 13))
                                Text(error)
                                    .font(.system(size: 13, weight: .medium))
                            }
                            .foregroundStyle(Color("ColorPrimary"))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("ColorPrimary").opacity(0.08))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("ColorPrimary").opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }

                        // Success banner
                        if viewModel.isSuccess {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 13))
                                Text("Đăng ký thành công! Đang chuyển hướng...")
                                    .font(.system(size: 13, weight: .medium))
                            }
                            .foregroundStyle(Color("SuccessTeal"))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("SuccessTeal").opacity(0.08))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("SuccessTeal").opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }

                        // Submit button
                        SubmitButton(title: "Đăng ký") {
                            Task { await viewModel.register() }
                        }

                        // Divider
                        HStack(spacing: 12) {
                            Rectangle().fill(Color.primary.opacity(0.08)).frame(height: 1)
                            Text("hoặc")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.tertiary)
                            Rectangle().fill(Color.primary.opacity(0.08)).frame(height: 1)
                        }

                        // Login link
                        HStack(spacing: 6) {
                            Text("Đã có tài khoản?")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 15))

                            Button {
                                DispatchQueue.main.async {
                                    appState.authState = .login
                                }
                            } label: {
                                Text("Đăng nhập")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color("ColorPrimary"))
                            }
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                            .fill(Color.clear)
                    )
                    .glassPanel()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 48)
                }
            }
        }
        .onChange(of: viewModel.firstName.value) { viewModel.validateFirstName() }
        .onChange(of: viewModel.lastName.value) { viewModel.validateLastName() }
        .onChange(of: viewModel.email.value) { viewModel.validateEmail() }
        .onChange(of: viewModel.password.value) {
            viewModel.validatePassword()
            viewModel.validateConfirmPassword()
        }
        .onChange(of: viewModel.confirmPassword.value) { viewModel.validateConfirmPassword() }
        .onChange(of: viewModel.isSuccess) {
            if viewModel.isSuccess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    appState.authState = .login
                }
            }
        }
    }
}

#Preview {
    RegisterView().environmentObject(AppState())
}
