//
//  UserProfileAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/4/26.
//

import Foundation

final class UserProfileAPIService {

    // MARK: - Fetch All System Data
    func fetchAllergies() async throws -> [Allergy] {
        let request = try UserProfileAPI.allergiesRequest()

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Allergy]>.self
        )
        
        return response.data
    }

    // MARK: - Allergy Profile
    func getAllergyProfile(
        profileId: String
    ) async throws -> [Allergy] {
        let request = try UserProfileAPI.allergyProfileRequest(profileId: profileId)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Allergy]>.self
        )

        return response.data
    }

    func addAllergy(
        profileId: String,
        allergyId: String
    ) async throws -> Allergy {
        let request = try UserProfileAPI.addAllergyRequest(
            profileId: profileId,
            allergyId: allergyId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<Allergy>.self
        )

        return response.data
    }

    func deleteAllergy(
        profileId: String,
        allergyId: String
    ) async throws -> Bool {
        let request = try UserProfileAPI.deleteAllergyRequest(
            profileId: profileId,
            allergyId: allergyId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<Bool>.self
        )

        return response.data
    }
    
    // MARK: - Profile Information
    func updateProfile(
        profileId: String,
        firstName: String?,
        lastName: String?,
        avatar: String?
    ) async throws -> Profile {
        let request = try UserProfileAPI.updateUserProfileRequest(
                profileId: profileId,
                firstName: firstName,
                lastName: lastName,
                avatar: avatar
            )
        
        let response = try await APIClient.shared.request(request, responseType: APIResponse<Profile>.self)
        
        return response.data
    }
    
    func getFamilyMembers(
        profileId: String
    ) async throws -> [Profile] {
        let request = try UserProfileAPI.familyMembersRequest(profileId: profileId)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Profile]>.self
        )

        return response.data
    }
    
    func createProfile(
        firstName: String?,
        lastName: String?,
        avatar: String?
    )async throws -> Profile {
        let request = try UserProfileAPI.addFamilyMembersRequest(
            firstName: firstName,
            lastName: lastName,
            avatar: avatar
        )
        
        let response = try await APIClient.shared.request(request, responseType: APIResponse<Profile>.self)
        
        return response.data
    }
    
    func deleteProfile(
        profileId: String
    ) async throws -> Bool {
        let request = try UserProfileAPI.deleteProfileRequest(
            profileId: profileId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<Bool>.self
        )

        return response.data
    }
}
