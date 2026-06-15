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
            description: self.description,
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
            description: self.description,
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
            description: self.description,
            type: "additive"
        )
    }
}

