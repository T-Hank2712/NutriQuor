//
//  Nutrition.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//
import Foundation
struct Nutrient: Identifiable, Codable {
    let id: String
    let name: String
    let key: String
    let description: String?
    let effects: [HealthEffect]?
    let found_in: [FoodCategory]?
}

struct NutriText: Identifiable, Equatable {
    let id = UUID()
    let text: String
}

