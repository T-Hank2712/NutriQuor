//
//  UserProfileAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/4/26.
//

import Foundation

final class UserProfileAPIService{
    
    // Fetch All System Data
    func fetchAllergies() async throws -> [Allergy] {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/allergies")!
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let allergies = try decoder.decode([Allergy].self, from: data)

        return allergies
    }
    func fetchDiseases() async throws -> [Disease] {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/diseases")!
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let diseases = try decoder.decode([Disease].self, from: data)

        return diseases
    }
    func fetchHealthGoals() async throws -> [HealthGoal] {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/health-goals")!
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let health_goals = try decoder.decode([HealthGoal].self, from: data)

        return health_goals
    }
    
    // Load the data of the current user profile.
    func getHealthGoalsByUser(profileId: Int) async throws -> [HealthGoal] {

        let url = URL(
            string:
            "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/health-goals"
        )!

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        if let token = TokenStorage.shared.getAccessToken() {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        let (data, _) = try await URLSession.shared.data(for: request)

        print(String(data: data, encoding: .utf8)!)

        let decoder = JSONDecoder()

        let response = try decoder.decode(
            APIResponse<[HealthGoal]>.self,
            from: data
        )

        return response.data
    }
    
    func addHealthGoal(
        profileId: Int,
        healthGoalId: Int
    ) async throws -> [HealthGoal] {

        let url = URL(
            string:
            "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/health-goals/\(healthGoalId)"
        )!

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        if let token = TokenStorage.shared.getAccessToken() {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        let (data, _) = try await URLSession.shared.data(
            for: request
        )

        print(String(data: data, encoding: .utf8)!)

        let decoder = JSONDecoder()

        let response = try decoder.decode(
            APIResponse<[HealthGoal]>.self,
            from: data
        )

        return response.data
    }
    
    func deleteHealthGoal(
        profileId: Int,
        healthGoalId: Int
    ) async throws -> [HealthGoal] {

        let url = URL(
            string:
            "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/health-goals/\(healthGoalId)"
        )!

        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        if let token = TokenStorage.shared.getAccessToken() {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        if let httpResponse = response as? HTTPURLResponse {

            if !(200...299).contains(httpResponse.statusCode) {

                print(String(data: data, encoding: .utf8)!)

                throw URLError(.badServerResponse)
            }
        }

        print(String(data: data, encoding: .utf8)!)

        let decoder = JSONDecoder()

        let apiResponse = try decoder.decode(
            APIResponse<[HealthGoal]>.self,
            from: data
        )

        return apiResponse.data
    }
}
