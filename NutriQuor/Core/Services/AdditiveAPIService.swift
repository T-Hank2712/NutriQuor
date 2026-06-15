//
//  AdditiveAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

final class AdditiveAPIService {
    func fetchAdditives() async throws -> [Additive] {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v1/additives")!
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let additives = try decoder.decode([Additive].self, from: data)

        return additives
    }
}
