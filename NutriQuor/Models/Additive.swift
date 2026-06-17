//
//  Additive.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation
struct Additive: Identifiable, Codable {
    let id: String
    let name: String
    let key: String
    let code: String?
    let description: String?
    let effects: [HealthEffect]?
    let found_in: [FoodCategory]?
}
