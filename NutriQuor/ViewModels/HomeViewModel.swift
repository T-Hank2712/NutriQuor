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
    
    @Published var todayScanCount = 0
    
    private let productService = ProductService()
    private let scanHistoryManager = ScanHistoryManager.shared
    
    private var userId: String?
    
    func updateUserId(_ id: String?) {
        self.userId = id
    }
    
    func scanCountToday() {
        guard let userId else {
               todayScanCount = 0
                return
           }

           todayScanCount = scanHistoryManager.count(
               on: Date(),
               userId: userId
           )
    }
    
    func loadTodayScanHistory() {
        guard let userId else {
            scanHistory = []
            return
        }
        
        scanHistory = scanHistoryManager
            .getAll(userId: userId)
            .filter {
                Calendar.current.isDateInToday($0.scannedAt)
            }
    }
}
