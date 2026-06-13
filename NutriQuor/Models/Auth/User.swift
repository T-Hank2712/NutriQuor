//
//  User.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
    }
}
