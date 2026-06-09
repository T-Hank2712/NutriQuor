import Foundation

struct ProductDTO: Decodable, Identifiable {
    struct Nutrition: Decodable {
        let energy: String?
        let protein: String?
        let fat: String?
        let sugar: String?
    }

    let id: Int
    let userId: Int
    let productName: String
    let ageRange: String?
    let ingredients: [String]?
    let additive: [String]?
    let nutrition: Nutrition?
    let manufacturer: String?
    let mfgDate: String?
    let expiryDate: String?
    let netWeight: String?
    let allergen: String?
    let warning: String?
    let origin: String?
    let createdAt: String?
    let timeZone: String?
    let createdAtLocal: Date?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "user_id"
        case productName = "product_name"
        case ageRange = "age_range"
        case ingredients
        case additive
        case nutrition
        case manufacturer
        case mfgDate = "mfg_date"
        case expiryDate = "expiry_date"
        case netWeight = "net_weight"
        case allergen
        case warning
        case origin
        case createdAt
        case timeZone
        case createdAtLocal
    }
}

private extension String {
    var toNumber: Double {
        let filtered = self
            .replacingOccurrences(of: ",", with: ".")
            .components(separatedBy: CharacterSet(charactersIn: "0123456789.").inverted)
            .joined()
        return Double(filtered) ?? 0
    }
}
