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
    @Published var allergyList: [Allergy] = []
    @Published var selectedAllergies: [Allergy] = []
    
    @Published var profiles: [Profile] = []
    @Published var members: [Profile] = []
    private let userProfileService = UserProfileAPIService()
    func loadAllergies() async{
        do {
            let result = try await userProfileService.fetchAllergies()
            allergyList = result
        } catch {
        }
    }
    
    func bootstrap(profileId: String) async {
        do {
            async let allergies = userProfileService.getAllergyProfile(profileId: profileId)
            async let members = userProfileService.getFamilyMembers(profileId: profileId)

            let (a, m) = try await (allergies, members)

            self.selectedAllergies = a
            self.members = m

        } catch {
        }
    }
    
    // MARK: - Profile
    // Allergies Profile
    func loadProfileAllergies(profileId: String) async {
        
        do {
            
            selectedAllergies = try await userProfileService
                .getAllergyProfile(profileId: profileId)
            
        } catch {
        }
    }
    
    func addAllergy(profileId: String, allergyId: String) async {
        do {
            let newAllergy = try await userProfileService
                .addAllergy(profileId: profileId, allergyId: allergyId)

            selectedAllergies.append(newAllergy)

        } catch {
        }
    }
    
    func deleteAllergy(profileId: String, allergyId: String) async -> Bool {
        do {
            
            let success = try await userProfileService
                .deleteAllergy(profileId: profileId, allergyId: allergyId)
            if success {
                selectedAllergies.removeAll {
                    $0.id == allergyId
                }
            }
            return success
        } catch {
            return false
        }
    }
    
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
