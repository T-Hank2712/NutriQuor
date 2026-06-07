//
//  UserProfileViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 28/4/26.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject {
    @Published var currentProfile: Profile?
    @Published var allergyList: [Allergy] = []
    @Published var diseaseList: [Disease] = []
    @Published var healthGoals: [HealthGoal] = []
    @Published var selectedHealthGoals: [HealthGoal] = []
    @Published var selectedDiseases: [Disease] = []
    @Published var selectedAllergies: [Allergy] = []
    
    @Published var profiles: [Profile] = []
    @Published var members: [Profile] = []
    private let userProfileService = UserProfileAPIService()
    func loadAllergies() async{
        do {
            let result = try await userProfileService.fetchAllergies()
            allergyList = result
        } catch {
            print("Error loading data:", error)
        }
    }
    func loadDiseases() async{
        do {
            let result = try await userProfileService.fetchDiseases()
            diseaseList = result
        } catch {
            print("Error loading data:", error)
        }
    }
    func loadHealthGoals() async {
        do {
            let result = try await userProfileService.fetchHealthGoals()
            healthGoals = result
        } catch {
            print("Error loading data:", error)
        }
    }
    
    // MARK: - Profile
    // Health Goals Profile
    func loadProfileGoals(profileId: Int) async {
        
        do {
            
            selectedHealthGoals = try await userProfileService
                .getHealthGoalProfile(profileId: profileId)
            
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
    
    // Diseases Profile
    func loadProfileDiseases(profileId: Int) async {
        
        do {
            
            selectedDiseases = try await userProfileService
                .getDiseaseProfile(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addDisease(profileId: Int, diseaseId: Int) async {
        do {
            
            selectedDiseases = try await userProfileService
                .addDisease(profileId: profileId, diseaseId: diseaseId)
            
        } catch {
            print(error)
        }
    }
    
    func deleteDisease(profileId: Int, diseaseId: Int) async {
        do {
            
            selectedDiseases = try await userProfileService
                .deleteDisease(profileId: profileId, diseaseId: diseaseId)
            
        } catch {
            print(error)
        }
    }
    
    // Allergies Profile
    func loadProfileAllergies(profileId: Int) async {
        
        do {
            
            selectedAllergies = try await userProfileService
                .getAllergyProfile(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addAllergy(profileId: Int, allergyId: Int) async {
        do {
            
            selectedAllergies = try await userProfileService
                .addAllergy(profileId: profileId, allergyId: allergyId)
            
        } catch {
            print(error)
        }
    }
    
    func deleteAllergy(profileId: Int, allergyId: Int) async {
        do {
            
            selectedAllergies = try await userProfileService
                .deleteAllergy(profileId: profileId, allergyId: allergyId)
            
        } catch {
            print(error)
        }
    }
    
    // MARK: - Profile Information
    func updateUserProfile(profileId: Int, firstName: String?, lastName: String?, avatar: String?) async -> Profile? {
        do {
            let updatedProfile = try await userProfileService
                .updateProfile(profileId: profileId, firstName: firstName, lastName: lastName, avatar: avatar)
            self.currentProfile = updatedProfile
            return updatedProfile 
        } catch {
            print(error)
            return nil
        }
    }
    
    func loadFamilyMembers(profileId: Int) async {
        do {
            
            members = try await userProfileService
                .getFamilyMembers(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addUserProfile(firstName: String?, lastName: String?, avatar: String?) async {
        do {
            profiles = try await userProfileService
                .createProfile(firstName: firstName, lastName: lastName, avatar: avatar)

        } catch {
            print(error)
        }
    }
    
    func deleteProfile(profileId: Int) async -> Bool {
        do {
            profiles = try await userProfileService.deleteProfile(profileId: profileId)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
