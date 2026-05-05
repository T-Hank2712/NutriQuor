//
//  UserProfileAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/4/26.
//

import Foundation

final class UserProfileAPIService{
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
    func addAllergy(name: String) async throws {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/allergies")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
