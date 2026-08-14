import Foundation

struct ScanHistory: Decodable, Identifiable {
    let analysisId: String
    let productName: String?
    let imageRef: String?
    let status: String?
    let warning: String?
    let createdAt: Date?

    var id: String { analysisId }

    enum CodingKeys: String, CodingKey {
        case analysisId = "analysis_id"
        case productName = "product_name"
        case imageRef = "image_ref"
        case status
        case warning
        case createdAt = "created_at"
    }

    init(
        analysisId: String,
        productName: String? = nil,
        imageRef: String? = nil,
        status: String? = nil,
        warning: String? = nil,
        createdAt: Date? = nil
    ) {
        self.analysisId = analysisId
        self.productName = productName
        self.imageRef = imageRef
        self.status = status
        self.warning = warning
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        analysisId = try container.decode(String.self, forKey: .analysisId)
        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        imageRef = try container.decodeIfPresent(String.self, forKey: .imageRef)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        warning = try container.decodeIfPresent(String.self, forKey: .warning)
        createdAt = HistoryDateParser.parse(
            try container.decodeIfPresent(String.self, forKey: .createdAt)
        )
    }
}

struct ScanHistoryDetail: Decodable {
    let analysisId: String
    let userId: String?
    let imageRef: String?
    let imageContentType: String?
    let status: String?
    let result: Product
    let createdAt: Date?
    let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case analysisId = "analysis_id"
        case userId = "user_id"
        case imageRef = "image_ref"
        case imageContentType = "image_content_type"
        case status
        case result
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        analysisId = try container.decode(String.self, forKey: .analysisId)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
        imageRef = try container.decodeIfPresent(String.self, forKey: .imageRef)
        imageContentType = try container.decodeIfPresent(String.self, forKey: .imageContentType)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        result = try container.decode(Product.self, forKey: .result)
        createdAt = HistoryDateParser.parse(
            try container.decodeIfPresent(String.self, forKey: .createdAt)
        )
        updatedAt = HistoryDateParser.parse(
            try container.decodeIfPresent(String.self, forKey: .updatedAt)
        )
    }
}

private enum HistoryDateParser {
    static func parse(_ raw: String?) -> Date? {
        guard let raw else { return nil }

        let isoWithFraction = ISO8601DateFormatter()
        isoWithFraction.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let isoWithoutFraction = ISO8601DateFormatter()
        isoWithoutFraction.formatOptions = [.withInternetDateTime]

        return isoWithFraction.date(from: raw) ?? isoWithoutFraction.date(from: raw)
    }
}
