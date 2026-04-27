//
//  MapSearchDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

extension Nutrient {
    func toSearchDTO() -> SearchDTO {
        return SearchDTO(
            id: "nutrient-\(self.id)",
            name: self.name,
            code: nil,
            image: self.image,
            description: self.description,
            effects: self.effects,
            found_in: self.found_in,
            type: "nutrient"
        )
    }
}

extension Ingredient {
    func toSearchDTO() -> SearchDTO {
        return SearchDTO(
            id: "ingredient-\(self.id)",
            name: self.name,
            code: nil,
            image: self.image,
            description: self.description,
            effects: self.effects,
            found_in: self.found_in,
            type: "ingredient"
        )
    }
}

extension Additive {
    func toSearchDTO() -> SearchDTO {
        return SearchDTO(
            id: "ingredient-\(self.id)",
            name: self.name,
            code: self.code,
            image: self.image,
            description: self.description,
            effects: self.effects,
            found_in: self.found_in,
            type: "additive"
        )
    }
}

