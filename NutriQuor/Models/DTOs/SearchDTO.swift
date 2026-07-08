//
//  SearchDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

struct SearchDTO: Identifiable, Decodable{
    let id: String
    let name: String
    let nameVi: String?
    let code: String?
    let defaultUnit: String?
    let description: String?
    let type: String
    let sections: [KnowledgeSection]

    enum CodingKeys: String, CodingKey {
        case id, name, code, description, type, sections
        case nameVi = "name_vi"
        case externalCode = "external_code"
        case defaultUnit = "default_unit"
        case ins
    }

    init(
        id: String,
        name: String,
        nameVi: String? = nil,
        code: String?,
        defaultUnit: String? = nil,
        description: String?,
        type: String,
        sections: [KnowledgeSection] = []
    ) {
        self.id = id
        self.name = name
        self.nameVi = nameVi
        self.code = code
        self.defaultUnit = defaultUnit
        self.description = description
        self.type = type
        self.sections = sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nameVi = try container.decodeIfPresent(String.self, forKey: .nameVi)
        code = try container.decodeFirstString(forKeys: [.code, .externalCode, .ins])
        defaultUnit = try container.decodeIfPresent(String.self, forKey: .defaultUnit)
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

    var displayName: String {
        guard let nameVi, !nameVi.isEmpty else { return name }
        return nameVi
    }

    var displayCode: String? {
        guard let code, !code.isEmpty else { return defaultUnit }

        if type == "additive" {
            return "INS \(code)"
        }

        if let defaultUnit, !defaultUnit.isEmpty {
            return "\(code) · \(defaultUnit)"
        }

        return code
    }

    var searchText: String {
        ([
            id,
            name,
            nameVi,
            code,
            defaultUnit,
            type,
            description
        ] + sections.flatMap { [$0.title, $0.sectionType, $0.content] })
            .compactMap { $0 }
            .joined(separator: " ")
    }
}

private extension KeyedDecodingContainer where K == SearchDTO.CodingKeys {
    func decodeFirstString(forKeys keys: [K]) throws -> String? {
        for key in keys {
            if let value = try decodeIfPresent(String.self, forKey: key), !value.isEmpty {
                return value
            }
        }
        return nil
    }
}
