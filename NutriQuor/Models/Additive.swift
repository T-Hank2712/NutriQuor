//
//  Additive.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation
struct Additive: Identifiable, Codable {
    let id: Int
    let name: String
    let code: String?
    let description: String
    let image: String
    let effects: [HealthEffect]
    let found_in: [FoodCategory]
}
