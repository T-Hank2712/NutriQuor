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
                VStack(spacing: 22) {

                    // MARK: - Hero Header
                    BentoCard(accent: Color("ColorPrimary"), style: .plain, padding: 18) {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color("ColorPrimary").opacity(0.12))
                                    .frame(width: 62, height: 62)

                                Image(systemName: "person.fill")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(Color("ColorPrimary"))
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(appState.profile?.lastName ?? "") \(appState.profile?.firstName ?? "Người dùng")")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundStyle(.primary)
                                    .lineLimit(1)

                                Text(appState.user?.email ?? "")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }

                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)

                    // MARK: - Content
                    VStack(spacing: 20) {

                        // Account
                        ModernSection(title: "TÀI KHOẢN", icon: "person.crop.circle") {
                            FullScreenDetailLink {
                                ProfileView()
                            } label: {
                                ModernOptionRow(
                                    title: "Chỉnh sửa hồ sơ",
                                    subtitle: "Tên và thông tin tài khoản",
                                    icon: "person.text.rectangle.fill",
                                    iconColor: Color("ColorPrimary")
                                )
                            }
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

                        // Logout
                        
                        DangerButton(
                            title: "Đăng xuất",
                            icon: "rectangle.portrait.and.arrow.right",
                            color: .red
                        ) {
                            appState.logout()
                        }

                        Text("NutriQuor v1.0.0")
                            .font(.system(size: 12))
                            .foregroundStyle(.tertiary)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(Color("Background"))
        }
        .restoreBottomBarOnRoot()
    }
}

#Preview {
    SettingView().environmentObject(AppState())
}
