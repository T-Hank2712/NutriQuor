//
//  SearchDetailDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 15/6/26.
//

import Foundation

struct SearchDetailDTO: Decodable {
    let id: String
    let name: String
    let code: String?
    let description: String?

    let effects: [HealthEffect]?
    let foundIn: [FoodCategory]?

    enum CodingKeys: String, CodingKey {
        case id, name, code, description, effects
        case foundIn = "categories"
    }
}
