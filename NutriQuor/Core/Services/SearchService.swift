//
//  SearchService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

final class SearchService {
    
    func fetchAll() async throws -> [SearchDTO]{
        let request = try SearchAPI.searchRequest()

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[SearchDTO]>.self
        )
        
        return response.data
    }
    
    func fetchDetail(id: String) async throws -> SearchDetailDTO{
        let request = try SearchAPI.searchDetailRequest(id: id)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<SearchDetailDTO>.self
        )
        return response.data
    }
}
