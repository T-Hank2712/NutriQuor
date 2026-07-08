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
            id: self.id,
            name: self.name,
            nameVi: self.nameVi,
            code: self.externalCode,
            defaultUnit: self.defaultUnit,
            description: self.description,
            type: "nutrient",
            sections: self.sections
        )
    }
}

extension Ingredient {
    func toSearchDTO() -> SearchDTO {
        return SearchDTO(
            id: self.id,
            name: self.name,
            code: nil,
            description: self.description,
            type: "ingredient",
            sections: self.sections
        )
    }
}

extension Additive {
    func toSearchDTO() -> SearchDTO {
        return SearchDTO(
            id: self.id,
            name: self.name,
            nameVi: self.nameVi,
            code: self.code,
            description: self.description,
            type: "additive",
            sections: self.sections
        )
    }
}
