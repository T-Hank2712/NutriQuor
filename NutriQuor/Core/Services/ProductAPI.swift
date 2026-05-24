import Foundation

enum ProductAPI {

    static func fetchProducts() async throws -> [ProductDTO] {
        guard let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/products/") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        return try decoder.decode([ProductDTO].self, from: data)
    }
}
