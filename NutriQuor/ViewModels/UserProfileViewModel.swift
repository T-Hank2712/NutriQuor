//
//  UserProfileViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/4/26.
//

import Foundation
import Combine

@MainActor
final class UserProfileViewModel: ObservableObject {
    @Published var currentProfile: Profile?
    
    @Published var profiles: [Profile] = []
    @Published var members: [Profile] = []
    private let userProfileService = UserProfileAPIService()
    
    func bootstrap(profileId: String) async {
        await loadFamilyMembers(profileId: profileId)
    }
    
    // MARK: - Profile
    // MARK: - Profile Information
    func updateUserProfile(profileId: String, firstName: String?, lastName: String?, avatar: String?) async -> Profile? {
        do {
            let updatedProfile = try await userProfileService
                .updateProfile(profileId: profileId, firstName: firstName, lastName: lastName, avatar: avatar)
            self.currentProfile = updatedProfile
            return updatedProfile 
        } catch {
            return nil
        }
    }
    
    func loadFamilyMembers(profileId: String) async {
        do {
            
            members = try await userProfileService
                .getFamilyMembers(profileId: profileId)
            
        } catch {
        }
    }
    
    func addUserProfile(firstName: String?, lastName: String?, avatar: String?) async {
        do {
            let profile = try await userProfileService
                .createProfile(
                    firstName: firstName,
                    lastName: lastName,
                    avatar: avatar
                )

            profiles.append(profile)

        } catch {
        }
    }
    
    func deleteProfile(profileId: String) async -> Bool {
        do {
            let success = try await userProfileService
                        .deleteProfile(profileId: profileId)
            if success {
                profiles.removeAll {
                    $0.profileId == profileId
                }
            }
            return success
        } catch {
            return false
        }
    }
}
