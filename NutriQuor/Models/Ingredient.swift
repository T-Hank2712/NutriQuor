//
//  Ingredient.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/4/26.
//

import Foundation
struct Ingredient: Identifiable, Decodable {
    let id: String
    let name: String
    let key: String
    let description: String?
    let sections: [KnowledgeSection]

    enum CodingKeys: String, CodingKey {
        case id, name, key, description, sections
    }

    init(
        id: String,
        name: String,
        key: String,
        description: String?,
        sections: [KnowledgeSection] = []
    ) {
        self.id = id
        self.name = name
        self.key = key
        self.description = description
        self.sections = sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? id
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []

        let overview = sections.first { $0.sectionType == "overview" }?.content
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? overview
    }
}
