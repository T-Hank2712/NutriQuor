//
//  Profile.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation

struct Profile: Codable {
    
    let profileId: Int
    
    let userId: Int
    
    let firstName: String
    let lastName: String
    
    let avatar: String?
    
    let healthGoals: [HealthGoal]
    
    let diseases: [Disease]
    
    let allergies: [Allergy]
    
    let familyMembers: [Profile]
    
    let parentProfileId: Int?
    
    enum CodingKeys: String, CodingKey {
        case profileId = "profile_id"
        
        case userId
        
        case firstName = "first_name"
        case lastName = "last_name"
        
        case avatar
        
        case healthGoals = "health_goals"
        
        case diseases
        case allergies
        
        case familyMembers = "family_members"
        
        case parentProfileId = "parent_profile_id"
    }
}
