//
//  HomeViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 17/6/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var scanHistory: [ScanHistory] = []
    
    @Published var daily: SearchDTO?
    
    @Published var todayScanCount = 0
    
    private let scanHistoryService = ScanHistoryService()
    private let searchService = SearchService()
    
    private var userId: String?
    
    func updateUserId(_ id: String?) {
        self.userId = id
    }
    
    func loadTodayScanHistory() async {
        guard userId != nil else {
            scanHistory = []
            todayScanCount = 0
            return
        }

        do {
            let histories = try await scanHistoryService.fetchHistory(date: Date(), limit: 20)
            scanHistory = histories
            todayScanCount = histories.count
        } catch {
            scanHistory = []
            todayScanCount = 0
            errorMessage = UserMessageMapper.message(for: error)
        }
    }
    
    func loadDailyFeature() async {
        do {
            let result = try await searchService.fetchDailyFeature()
            daily = result
        } catch {
        }
    }
}
