//
//  Nutrition.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//
import Foundation
struct Nutrient: Identifiable, Decodable {
    let id: String
    let name: String
    let nameVi: String?
    let key: String
    let externalCode: String?
    let defaultUnit: String?
    let description: String?
    let sections: [KnowledgeSection]

    enum CodingKeys: String, CodingKey {
        case id, name, key, description, sections
        case nameVi = "name_vi"
        case externalCode = "external_code"
        case defaultUnit = "default_unit"
    }

    init(
        id: String,
        name: String,
        nameVi: String? = nil,
        key: String,
        externalCode: String? = nil,
        defaultUnit: String? = nil,
        description: String?,
        sections: [KnowledgeSection] = []
    ) {
        self.id = id
        self.name = name
        self.nameVi = nameVi
        self.key = key
        self.externalCode = externalCode
        self.defaultUnit = defaultUnit
        self.description = description
        self.sections = sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nameVi = try container.decodeIfPresent(String.self, forKey: .nameVi)
        externalCode = try container.decodeIfPresent(String.self, forKey: .externalCode)
        defaultUnit = try container.decodeIfPresent(String.self, forKey: .defaultUnit)
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? externalCode ?? id
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []

        let overview = sections.first { $0.sectionType == "overview" }?.content
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? overview
    }
}
