//
//  analyticsContent.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct AnalyticsContent: View {
    
    var selectedFilter: AnalystView.FilterType
    
    var body: some View {
        switch selectedFilter {
        case .today:
            TodayView()
        case .sevenDays:
            WeekView()
        case .thirtyDays:
           MonthView()
        }
    }
}
