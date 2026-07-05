//
//  SearchDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

struct SearchDTO: Identifiable, Codable{
    let id: String
    let name: String
    let code: String?
    let description: String?
    let type: String
    let sections: [KnowledgeSection]

    enum CodingKeys: String, CodingKey {
        case id, name, code, description, type, sections
    }

    init(
        id: String,
        name: String,
        code: String?,
        description: String?,
        type: String,
        sections: [KnowledgeSection] = []
    ) {
        self.id = id
        self.name = name
        self.code = code
        self.description = description
        self.type = type
        self.sections = sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? SearchDTO.typeFromId(id)

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
