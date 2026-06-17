//
//  AdditiveAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

final class AdditiveAPIService {
    func fetchAdditives() async throws -> [Additive] {
        let request = try AdditiveAPI.additivesRequest()

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Additive]>.self
        )
        
        return response.data
    }
}
