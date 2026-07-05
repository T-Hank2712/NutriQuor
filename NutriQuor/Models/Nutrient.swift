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
    let sections: [KnowledgeSection]
    let effects: [HealthEffect]?
    let found_in: [FoodCategory]?

    enum CodingKeys: String, CodingKey {
        case id, name, key, description, sections, effects, found_in
    }

    init(
        id: String,
        name: String,
        key: String,
        description: String?,
        sections: [KnowledgeSection] = [],
        effects: [HealthEffect]?,
        found_in: [FoodCategory]?
    ) {
        self.id = id
        self.name = name
        self.key = key
        self.description = description
        self.sections = sections
        self.effects = effects
        self.found_in = found_in
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? id
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []
        effects = try container.decodeIfPresent([HealthEffect].self, forKey: .effects)
        found_in = try container.decodeIfPresent([FoodCategory].self, forKey: .found_in)

        let overview = sections.first { $0.sectionType == "overview" }?.content
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? overview
    }
}

struct NutriText: Identifiable, Equatable {
    let id = UUID()
    let text: String
}
