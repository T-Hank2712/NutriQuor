import Foundation
import UIKit

final class ProductService {
    func analyzeProduct(image: UIImage) async throws -> Product {
        let request = try ProductAPI.analyzeProductRequest(image: image)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<Product>.self
        )

        return response.data
    }
}
