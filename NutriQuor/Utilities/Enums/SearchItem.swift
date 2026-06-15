//
//  SearchItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/4/26.
//

import Foundation
enum SearchItem: Identifiable {
    case nutrient(Nutrient)
    case ingredient(Ingredient)
    case additive(Additive)

    var id: String {
        switch self {
        case .nutrient(let n): return "n-\(n.id)"
        case .ingredient(let i): return "i-\(i.id)"
        case .additive(let a): return "a-\(a.id)"
        }
    }

    var name: String {
        switch self {
        case .nutrient(let n): return n.name
        case .ingredient(let i): return i.name
        case .additive(let a): return a.name
        }
    }
    
    var description: String {
        switch self {
        case .nutrient(let n): return n.description ?? ""
        case .ingredient(let i): return i.description ?? ""
        case .additive(let a): return a.description ?? ""
        }
    }
    
    var effects: [HealthEffect] {
        switch self {
        case .nutrient(let n): return n.effects
        case .ingredient(let i): return i.effects
        case .additive(let a): return a.effects
        }
    }
    
    var found_in: [FoodCategory] {
        switch self {
        case .nutrient(let n): return n.found_in
        case .ingredient(let i): return i.found_in
        case .additive(let a): return a.found_in
        }
    }
}
