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
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Header
                    VStack{
                        ZStack(alignment: .bottomTrailing) {

                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 96, height: 96)
                                .clipShape(Circle())

                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                Text("Premium")
                            }
                            .font(.caption2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color(.colorPrimary))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .offset(x: 6, y: 6)
                        }

                        Text("\(appState.profile?.lastName ?? "Lâm") \(appState.profile?.firstName ?? "Thành")")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Sections
                    SettingsSection(title: "Account") {
                        NavigationLink {
                            ProfileView()
                        } label: {
                            OptionCard(
                                title: "Edit Profile",
                                icon: "person.circle",
                                color: Color(.colorPrimary)
                            )
                        }.buttonStyle(.plain)
                        OptionCard(
                            title: "Change Your Password",
                            icon: "lock.circle",
                            color: Color(.colorPrimary)
                        )
                    }
                    
                    SettingsSection(title: "App Preferences") {
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Appearance")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Picker("Appearance", selection: $appTheme) {
                                Text("System").tag(AppearanceMode.system.rawValue)
                                Text("Light").tag(AppearanceMode.light.rawValue)
                                Text("Dark").tag(AppearanceMode.dark.rawValue)
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    SettingsSection(title: "Support & Legal") {
                        OptionCard(
                            title: "Help Center",
                            icon: "questionmark.circle",
                            color: Color(.colorPrimary)
                        )
                        OptionCard(
                            title: "Privacy Policy",
                            icon: "shield.pattern.checkered",
                            color: Color(.colorPrimary)
                        )
                    }
                    
                    // Logout Button
                    Button(action: {
                        appState.logout()
                        appState.authState = .login
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.square")
                            Text("Log Out")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.red, lineWidth: 1.5)
                        )
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                }
                .padding(.vertical)
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    SettingView().environmentObject(AppState())
}
