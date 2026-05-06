//
//  UserProfileViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/4/26.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject {
    @Published var allergyList: [Allergy] = []
    @Published var diseaseList: [Disease] = []
    @Published var healthGoals: [HealthGoal] = []
    private let userProfileService = UserProfileAPIService()
    func loadAllergies() async{
        do {
            let result = try await userProfileService.fetchAllergies()
            allergyList = result
            print(allergyList)
        } catch {
            print("Error loading data:", error)
        }
    }
    func loadDiseases() async{
        do {
            let result = try await userProfileService.fetchDiseases()
            diseaseList = result
            print(diseaseList)
        } catch {
            print("Error loading data:", error)
        }
    }
    func loadHealthGoals() async {
        do {
            let result = try await userProfileService.fetchHealthGoals()
            healthGoals = result
            print(healthGoals)
        } catch {
            print("Error loading data:", error)
        }
    }
}
