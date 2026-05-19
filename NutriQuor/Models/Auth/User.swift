//
//  User.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let passwordHash: String
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
    let profileId: Int
    enum CodingKeys: String, CodingKey {
        case id
        case email
        
        case passwordHash = "password_hash"
        
        case isActive = "is_active"
        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
        case profileId = "profile_id"
    }
}
