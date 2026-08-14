import Foundation

enum ScanHistoryAPI {
    static func listRequest(date: Date? = nil, limit: Int = 50) throws -> URLRequest {
        var components = URLComponents(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/scan-history"
        )

        var queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)")
        ]

        if let date {
            queryItems.append(
                URLQueryItem(name: "date", value: Self.historyDateFormatter.string(from: date))
            )
        }

        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

    static func detailRequest(analysisId: String) throws -> URLRequest {
        guard let encodedId = analysisId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v1/scan-history/\(encodedId)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

    private static let historyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
