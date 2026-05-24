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
    @Published var selectedHealthGoals: [HealthGoal] = []
    @Published var selectedDisease: [Disease] = []
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
    
    // MARK: - Profile
    // Health Goals
    func loadProfileGoals(profileId: Int) async {
        
        do {
            
            selectedHealthGoals = try await userProfileService
                .getHealthGoalsByUser(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addHealthGoal(profileId: Int, healthGoalId: Int) async {
        do {
            
            selectedHealthGoals = try await userProfileService
                .addHealthGoal(profileId: profileId, healthGoalId: healthGoalId)
            
        } catch {
            print(error)
        }
    }
    
    func deleteHealthGoal(profileId: Int, healthGoalId: Int) async {
        do {
            
            selectedHealthGoals = try await userProfileService
                .deleteHealthGoal(profileId: profileId, healthGoalId: healthGoalId)
            
        } catch {
            print(error)
        }
    }
    
    // Diseases
    func loadProfileDiseases(profileId: Int) async {
        
        do {
            
            selectedDisease = try await userProfileService
                .getDiseaseProfiles(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addDisease(profileId: Int, diseaseId: Int) async {
        do {
            
            selectedDisease = try await userProfileService
                .addDisease(profileId: profileId, diseaseId: diseaseId)
            
        } catch {
            print(error)
        }
    }
    
    func deleteDisease(profileId: Int, diseaseId: Int) async {
        do {
            
            selectedDisease = try await userProfileService
                .deleteDisease(profileId: profileId, diseaseId: diseaseId)
            
        } catch {
            print(error)
        }
    }
}
