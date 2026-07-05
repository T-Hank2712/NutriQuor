//
//  SearchDetailDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 15/6/26.
//

import Foundation

struct KnowledgeSection: Identifiable, Codable {
    let id = UUID()
    let sectionType: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case sectionType = "section_type"
        case content
    }
}

struct SearchDetailDTO: Decodable {
    let id: String
    let name: String
    let type: String
    let code: String?
    let description: String?
    let sections: [KnowledgeSection]

    let effects: [HealthEffect]?
    let foundIn: [FoodCategory]?

    enum CodingKeys: String, CodingKey {
        case id, name, type, code, description, sections, effects
        case foundIn = "categories"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? SearchDetailDTO.typeFromId(id)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []
        effects = try container.decodeIfPresent([HealthEffect].self, forKey: .effects)
        foundIn = try container.decodeIfPresent([FoodCategory].self, forKey: .foundIn)

        let overview = sections.first { $0.sectionType == "overview" }?.content
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? overview
    }

    private static func typeFromId(_ id: String) -> String {
        if id.hasPrefix("NUTRIENT:") {
            return "nutrient"
        }

        if id.hasPrefix("INGREDIENT:") {
            return "ingredient"
        }

        if id.hasPrefix("ADDITIVE:") {
            return "additive"
        }

        return "unknown"
    }
}
