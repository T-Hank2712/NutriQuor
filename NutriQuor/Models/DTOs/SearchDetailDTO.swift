//
//  SearchDetailDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 15/6/26.
//

import Foundation

struct KnowledgeSection: Identifiable, Decodable {
    let id = UUID()
    let sectionType: String
    let title: String?
    let content: String

    enum CodingKeys: String, CodingKey {
        case sectionType = "section_type"
        case title
        case content
    }
}

struct SearchDetailDTO: Decodable {
    let id: String
    let name: String
    let nameVi: String?
    let type: String
    let code: String?
    let defaultUnit: String?
    let description: String?
    let sections: [KnowledgeSection]

    enum CodingKeys: String, CodingKey {
        case id, name, type, code, description, sections
        case nameVi = "name_vi"
        case externalCode = "external_code"
        case defaultUnit = "default_unit"
        case ins
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nameVi = try container.decodeIfPresent(String.self, forKey: .nameVi)
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? SearchDetailDTO.typeFromId(id)
        code = try container.decodeFirstString(forKeys: [.code, .externalCode, .ins])
        defaultUnit = try container.decodeIfPresent(String.self, forKey: .defaultUnit)
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []

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

    var displayName: String {
        guard let nameVi, !nameVi.isEmpty else { return name }
        return nameVi
    }
}

private extension KeyedDecodingContainer where K == SearchDetailDTO.CodingKeys {
    func decodeFirstString(forKeys keys: [K]) throws -> String? {
        for key in keys {
            if let value = try decodeIfPresent(String.self, forKey: key), !value.isEmpty {
                return value
            }
        }
        return nil
    }
}
