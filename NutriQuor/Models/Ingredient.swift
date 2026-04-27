//
//  Ingredient.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/4/26.
//

import Foundation
struct Ingredient: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let image: String
    let effects: [HealthEffect]
    let found_in: [FoodCategory]
}
