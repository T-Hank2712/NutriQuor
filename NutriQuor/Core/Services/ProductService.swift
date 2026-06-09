import Foundation

final class ProductService {

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
    
    static func getProducts() async throws -> [ProductDTO] {
        let request = try ProductAPI.fetchProducts()

        do {
            let response = try await APIClient.shared.request(
                request,
                responseType: APIResponse<[ProductDTO]>.self
            )

            return response.data
        } catch {
            throw error
        }
    }
    
    static func getProductsByDate(day: Int, month: Int, year: Int) async throws -> [ProductDTO] {
        let request = try ProductAPI.fetchProductsByDate(day: day, month: month, year: year)
        
        do {
            let response = try await APIClient.shared.request(
                request,
                responseType: APIResponse<[ProductDTO]>.self
            )
            
            return response.data
        }
    }
}
