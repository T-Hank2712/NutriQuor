//
//  SearchService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

final class SearchService {
     func fetchAllItem() async throws -> [SearchDTO] {
        guard let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/search-nutrition/") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        return try decoder.decode([SearchDTO].self, from: data)
    }
}
