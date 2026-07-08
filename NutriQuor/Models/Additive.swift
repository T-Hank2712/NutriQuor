//
//  Additive.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

struct Additive: Identifiable, Decodable {
    let id: String
    let name: String
    let nameVi: String?
    let key: String
    let code: String?
    let description: String?
    let sections: [KnowledgeSection]

    enum CodingKeys: String, CodingKey {
        case id, name, key, code, description, sections
        case nameVi = "name_vi"
        case ins
    }

    init(
        id: String,
        name: String,
        nameVi: String? = nil,
        key: String,
        code: String?,
        description: String?,
        sections: [KnowledgeSection] = []
    ) {
        self.id = id
        self.name = name
        self.nameVi = nameVi
        self.key = key
        self.code = code
        self.description = description
        self.sections = sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nameVi = try container.decodeIfPresent(String.self, forKey: .nameVi)
        code = try container.decodeFirstString(forKeys: [.code, .ins])
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? code ?? id
        sections = try container.decodeIfPresent([KnowledgeSection].self, forKey: .sections) ?? []

        let overview = sections.first { $0.sectionType == "overview" }?.content
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? overview
    }
}

private extension KeyedDecodingContainer where K == Additive.CodingKeys {
    func decodeFirstString(forKeys keys: [K]) throws -> String? {
        for key in keys {
            if let value = try decodeIfPresent(String.self, forKey: key), !value.isEmpty {
                return value
            }
        }
        return nil
    }
}
