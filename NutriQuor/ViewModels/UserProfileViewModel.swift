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
            print(allergyList)
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
    
    func bootstrap(profileId: String) async {
        do {
            async let goals = userProfileService.getHealthGoalProfile(profileId: profileId)
            async let diseases = userProfileService.getDiseaseProfile(profileId: profileId)
            async let allergies = userProfileService.getAllergyProfile(profileId: profileId)
            async let members = userProfileService.getFamilyMembers(profileId: profileId)

            let (g, d, a, m) = try await (goals, diseases, allergies, members)

            self.selectedHealthGoals = g
            self.selectedDiseases = d
            self.selectedAllergies = a
            self.members = m

        } catch {
            print("BOOTSTRAP ERROR:", error)
        }
    }
    
    // MARK: - Profile
    // Health Goals Profile
    func loadProfileGoals(profileId: String) async {
        
        do {
            
            selectedHealthGoals = try await userProfileService
                .getHealthGoalProfile(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addHealthGoal(profileId: String, healthGoalId: String) async {
        do {
            
            selectedHealthGoals = try await userProfileService
                .addHealthGoal(profileId: profileId, healthGoalId: healthGoalId)
            
        } catch {
            print(error)
        }
    }
    
    func deleteHealthGoal(profileId: String, healthGoalId: String) async -> Bool {
        do {
            
            let success = try await userProfileService
                .deleteHealthGoal(profileId: profileId, healthGoalId: healthGoalId)
            if success {
                selectedHealthGoals.removeAll {
                    $0.id == healthGoalId
                }
            }
            return success
        } catch {
            print(error)
            return false
        }
    }
    
    // Diseases Profile
    func loadProfileDiseases(profileId: String) async {
        
        do {
            
            selectedDiseases = try await userProfileService
                .getDiseaseProfile(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addDisease(profileId: String, diseaseId: String) async {
        do {
            selectedDiseases = try await userProfileService
                .addDisease(
                    profileId: profileId,
                    diseaseId: diseaseId
                )
        } catch {
            print(error)
        }
    }

    func deleteDisease(profileId: String, diseaseId: String) async -> Bool {
        do {
            let success = try await userProfileService
                .deleteDisease(
                    profileId: profileId,
                    diseaseId: diseaseId
                )
            if success {
                selectedDiseases.removeAll {
                    $0.id == diseaseId
                }
            }
            return success
        } catch {
            print(error)
            return false
        }
    }
    // Allergies Profile
    func loadProfileAllergies(profileId: String) async {
        
        do {
            
            selectedAllergies = try await userProfileService
                .getAllergyProfile(profileId: profileId)
            
        } catch {
            print(error)
        }
    }
    
    func addAllergy(profileId: String, allergyId: String) async {
        do {
            
            selectedAllergies = try await userProfileService
                .addAllergy(profileId: profileId, allergyId: allergyId)
            
        } catch {
            print(error)
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
            print(error)
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
            print(error)
            return nil
        }
    }
    
    func loadFamilyMembers(profileId: String) async {
        do {
            
            members = try await userProfileService
                .getFamilyMembers(profileId: profileId)
            
        } catch {
            print(error)
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
            print(error)
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
            print(error)
            return false
        }
    }
}
