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
                        Color(.systemBackground),
                        Color("ColorPrimary").opacity(0.12)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Circle()
                    .fill(Color("ColorPrimary").opacity(0.18))
                    .frame(width: 360)
                    .blur(radius: 90)
                    .offset(x: -90, y: -320)

                Circle()
                    .fill(Color("ColorPrimary").opacity(0.12))
                    .frame(width: 260)
                    .blur(radius: 80)
                    .offset(x: 120, y: 260)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color("ColorPrimary"),
                                                Color("ColorPrimary").opacity(0.7)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 84, height: 84)
                                    .shadow(color: Color("ColorPrimary").opacity(0.4), radius: 22, y: 8)

                                Image(systemName: "heart.fill")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(Color(.systemBackground))
                            }

                            VStack(spacing: 6) {
                                Text("NutriQuor")
                                    .font(.system(size: 32, weight: .black, design: .rounded))
                                    .foregroundStyle(.primary)
                                    .kerning(-0.5)

                                Text("Know What's In Your Food")
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
                                    placeholder: "jane@example.com",
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
                            Button {
                                Task { await viewModel.login() }
                            } label: {
                                HStack(spacing: 10) {
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .tint(.primary)
                                            .scaleEffect(0.85)
                                    } else {
                                        Text("Đăng nhập")
                                            .font(.system(size: 17, weight: .bold, design: .rounded))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 15, weight: .bold))
                                    }
                                }
                                .foregroundStyle(Color(.systemBackground))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 17)
                                .background(
                                    Group {
                                        if viewModel.isLoading {
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color("ColorPrimary").opacity(0.5))
                                        } else {
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [Color("ColorPrimary"), Color("ColorPrimary").opacity(0.75)],
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                        }
                                    }
                                )
                                .shadow(
                                    color: viewModel.isLoading ? .clear : Color("ColorPrimary").opacity(0.45),
                                    radius: 16,
                                    y: 6
                                )
                            }
                            .disabled(viewModel.isLoading)

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
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                                        .stroke(Color.primary.opacity(0.06), lineWidth: 1)
                                )
                        )
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
