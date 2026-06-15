//
//  Ingredient.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/4/26.
//

import Foundation
struct Ingredient: Identifiable, Codable {
    let id: String
    let name: String
    let key: String
    let description: String?
    let effects: [HealthEffect]
    let found_in: [FoodCategory]
}
