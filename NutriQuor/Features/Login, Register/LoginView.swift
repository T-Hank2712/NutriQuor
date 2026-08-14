//
//  LoginView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject var appState: AppState

    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(appState: appState))
    }

    var body: some View {
        NavigationStack {
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
                        VStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 84, height: 84)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .cardRadius, style: .continuous)
                                            .stroke(Color.white.opacity(0.28), lineWidth: 1)
                                    )
                                    .shadow(color: Color.nqPrimary.opacity(0.18), radius: 18, y: 8)

                                Image(systemName: "heart.fill")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.nqPrimary, Color.nqInfo],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }

                            VStack(spacing: 6) {
                                Text("NutriQuor")
                                    .font(.system(size: 32, weight: .black, design: .rounded))
                                    .foregroundStyle(.primary)

                                Text("Hiểu rõ thực phẩm bạn dùng")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.secondary)
                                    .kerning(0.2)
                            }
                        }
                        .padding(.top, 56)

                        VStack(spacing: 22) {

                            // Title
                            VStack(spacing: 6) {
                                Text("Chào mừng trở lại")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundStyle(.primary)

                                Text("Đăng nhập để tiếp tục")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            // Fields
                            VStack(spacing: 16) {
                                DarkInputField(
                                    title: "Email",
                                    placeholder: "ten@example.com",
                                    icon: "envelope.fill",
                                    text: $viewModel.email,
                                    keyboard: .emailAddress
                                )

                                DarkSecureField(
                                    title: "Mật khẩu",
                                    placeholder: "Nhập mật khẩu",
                                    icon: "lock.fill",
                                    text: $viewModel.password
                                )
                            }

                            // Error
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

                            // Login Button
                            SubmitButton(title: "Đăng nhập") {
                                Task { await viewModel.login() }
                            }

                            // Divider
                            HStack(spacing: 12) {
                                Rectangle()
                                    .fill(Color.primary.opacity(0.08))
                                    .frame(height: 1)
                                Text("hoặc")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.tertiary)
                                Rectangle()
                                    .fill(Color.primary.opacity(0.08))
                                    .frame(height: 1)
                            }

                            // Sign up
                            HStack(spacing: 6) {
                                Text("Chưa có tài khoản?")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 15))

                                Button {
                                    appState.authState = .register
                                } label: {
                                    Text("Đăng ký ngay")
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
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

#Preview {
    let appState = AppState()
    return LoginView(appState: appState)
        .environmentObject(appState)
}
