
//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct AnalystView: View {
    enum FilterType: String, CaseIterable {
        case today = "Today"
        case sevenDays = "7 Days"
        case thirtyDays = "30 Days"
    }
    
    @State private var selectedFilter: FilterType = .today
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                VStack{
                    Text("Phân tích")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(.primary))
                    
                    // FILTER
                    HStack(spacing: 8) {
                        ForEach(FilterType.allCases, id: \.self) { filter in
                            Button {
                                selectedFilter = filter
                            } label: {
                                Text(filter.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedFilter == filter ? .white : .gray)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedFilter == filter ? Color(.primary) : Color.gray.opacity(0.15))
                                    )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                            .stroke(Color(.primary).opacity(0.4), lineWidth: 0.5)
                    )
                }
                
                AnalyticsContent(selectedFilter: selectedFilter)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    AnalystView()
}
