//
//  Profile.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation

struct Profile: Codable {
    let profileId: String
    let firstName: String
    let lastName: String
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case profileId = "profile_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
