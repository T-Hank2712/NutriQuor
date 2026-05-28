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

        return try await APIClient.shared.request(
            request,
            responseType: [Allergy].self
        )
    }

    func fetchDiseases() async throws -> [Disease] {
        let request = try UserProfileAPI.diseasesRequest()

        return try await APIClient.shared.request(
            request,
            responseType: [Disease].self
        )
    }

    func fetchHealthGoals() async throws -> [HealthGoal] {
        let request = try UserProfileAPI.healthGoalsRequest()

        return try await APIClient.shared.request(
            request,
            responseType: [HealthGoal].self
        )
    }

    // Load the data of the current user profile.
    // MARK: - Health Goal Profile
    func getHealthGoalProfile(profileId: Int) async throws -> [HealthGoal] {
        let request = try UserProfileAPI.healthGoalProfileRequest(profileId: profileId)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[HealthGoal]>.self
        )

        return response.data
    }

    func addHealthGoal(
        profileId: Int,
        healthGoalId: Int
    ) async throws -> [HealthGoal] {
        let request = try UserProfileAPI.addHealthGoalRequest(
            profileId: profileId,
            healthGoalId: healthGoalId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[HealthGoal]>.self
        )

        return response.data
    }

    func deleteHealthGoal(
        profileId: Int,
        healthGoalId: Int
    ) async throws -> [HealthGoal] {
        let request = try UserProfileAPI.deleteHealthGoalRequest(
            profileId: profileId,
            healthGoalId: healthGoalId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[HealthGoal]>.self
        )

        return response.data
    }

    // MARK: - Disease Profile
    func getDiseaseProfile(
        profileId: Int
    ) async throws -> [Disease] {
        let request = try UserProfileAPI.diseaseProfileRequest(profileId: profileId)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Disease]>.self
        )

        return response.data
    }

    func addDisease(
        profileId: Int,
        diseaseId: Int
    ) async throws -> [Disease] {
        let request = try UserProfileAPI.addDiseaseRequest(
            profileId: profileId,
            diseaseId: diseaseId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Disease]>.self
        )

        return response.data
    }

    func deleteDisease(
        profileId: Int,
        diseaseId: Int
    ) async throws -> [Disease] {
        let request = try UserProfileAPI.deleteDiseaseRequest(
            profileId: profileId,
            diseaseId: diseaseId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Disease]>.self
        )

        return response.data
    }

    // MARK: - Allergy Profile
    func getAllergyProfile(
        profileId: Int
    ) async throws -> [Allergy] {
        let request = try UserProfileAPI.allergyProfileRequest(profileId: profileId)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Allergy]>.self
        )

        return response.data
    }

    func addAllergy(
        profileId: Int,
        allergyId: Int
    ) async throws -> [Allergy] {
        let request = try UserProfileAPI.addAllergyRequest(
            profileId: profileId,
            allergyId: allergyId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Allergy]>.self
        )

        return response.data
    }

    func deleteAllergy(
        profileId: Int,
        allergyId: Int
    ) async throws -> [Allergy] {
        let request = try UserProfileAPI.deleteAllergyRequest(
            profileId: profileId,
            allergyId: allergyId
        )

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Allergy]>.self
        )

        return response.data
    }
    
    // MARK: - Profile Information
    func updateProfile(
        profileId: Int,
        firstName: String?,
        lastName: String?,
        avatar: String?
    ) async throws -> Profile {
        let request = try UserProfileAPI.updateUserProfile(
                profileId: profileId,
                firstName: firstName,
                lastName: lastName,
                avatar: avatar
            )
        
        let response = try await APIClient.shared.request(request, responseType: APIResponse<MeResponse>.self)
        
        return response.data.profile
    }
}
