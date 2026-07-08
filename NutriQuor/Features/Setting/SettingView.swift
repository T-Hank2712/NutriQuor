//
//  SettingView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 5/5/26.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("app_theme") private var appTheme: String = AppearanceMode.system.rawValue
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    // MARK: - Hero Header
                    ZStack {
                        LinearGradient(
                            colors: [
                                Color("DeepNavyDark"),
                                Color("DeepNavyMid"),
                                Color("ColorPrimary")
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea(edges: .top)

                        Circle()
                            .fill(Color.white.opacity(0.04))
                            .frame(width: 220)
                            .offset(x: -90, y: -30)
                        Circle()
                            .fill(Color("SuccessTeal").opacity(0.18))
                            .frame(width: 160)
                            .offset(x: 110, y: 40)

                        VStack(spacing: 14) {
                            // Avatar
                            ZStack(alignment: .bottomTrailing) {
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
                                        .frame(width: 96, height: 96)
                                        .shadow(color: Color("ColorPrimary").opacity(0.2), radius: 18, y: 8)

                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                        .foregroundStyle(.white.opacity(0.9))
                                }

                                // Premium Badge
                                HStack(spacing: 3) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 9, weight: .bold))
                                    Text("PRO")
                                        .font(.system(size: 9, weight: .black, design: .rounded))
                                        .kerning(0.5)
                                }
                                .padding(.horizontal, 7)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(Color("WarningAmber"))
                                        .shadow(color: Color("WarningAmber").opacity(0.28), radius: 6, y: 2)
                                )
                                .foregroundStyle(.white)
                                .offset(x: 8, y: 8)
                            }

                            VStack(spacing: 4) {
                                Text("\(appState.profile?.lastName ?? "") \(appState.profile?.firstName ?? "Người dùng")")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)

                                Text(appState.user?.email ?? "")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.vertical, 40)
                    }
                    .frame(maxWidth: .infinity)

                    // MARK: - Content
                    VStack(spacing: 24) {

                        // Account
                        ModernSection(title: "TÀI KHOẢN", icon: "person.crop.circle") {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                ModernOptionRow(
                                    title: "Chỉnh sửa hồ sơ",
                                    subtitle: "Tên, ảnh đại diện, thông tin cá nhân",
                                    icon: "person.text.rectangle.fill",
                                    iconColor: Color("ColorPrimary")
                                )
                            }
                            .buttonStyle(.plain)

                            Divider().padding(.leading, 56)

                            ModernOptionRow(
                                title: "Đổi mật khẩu",
                                subtitle: "Cập nhật mật khẩu bảo mật",
                                icon: "lock.fill",
                                iconColor: Color("InfoBlue")
                            )
                        }

                        // App Preferences
                        ModernSection(title: "GIAO DIỆN", icon: "paintbrush") {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("ColorPrimary").opacity(0.12))
                                            .frame(width: 36, height: 36)
                                        Image(systemName: "circle.lefthalf.filled")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(Color("ColorPrimary"))
                                    }
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Chế độ hiển thị")
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        Text("Sáng, tối hoặc theo hệ thống")
                                            .font(.system(size: 12))
                                            .foregroundStyle(.secondary)
                                    }
                                }

                                Picker("Appearance", selection: $appTheme) {
                                    Text("Hệ thống").tag(AppearanceMode.system.rawValue)
                                    Text("Sáng").tag(AppearanceMode.light.rawValue)
                                    Text("Tối").tag(AppearanceMode.dark.rawValue)
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(.vertical, 4)
                        }

                        // Support
                        ModernSection(title: "HỖ TRỢ & PHÁP LÝ", icon: "info.circle") {
                            ModernOptionRow(
                                title: "Trung tâm trợ giúp",
                                subtitle: "Câu hỏi thường gặp và hướng dẫn",
                                icon: "questionmark.circle.fill",
                                iconColor: Color("InfoBlue")
                            )

                            Divider().padding(.leading, 56)

                            ModernOptionRow(
                                title: "Chính sách bảo mật",
                                subtitle: "Điều khoản và quyền riêng tư",
                                icon: "shield.fill",
                                iconColor: Color("SuccessTeal")
                            )
                        }

                        // Logout
                        
                        DangerButton(
                            title: "Đăng xuất",
                            icon: "rectangle.portrait.and.arrow.right",
                            color: Color("AccentPink")
                        ) {
                            appState.logout()
                        }

                        Text("NutriQuor v1.0.0")
                            .font(.system(size: 12))
                            .foregroundStyle(.tertiary)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Color("Background"))
        }
    }
}

#Preview {
    SettingView().environmentObject(AppState())
}
