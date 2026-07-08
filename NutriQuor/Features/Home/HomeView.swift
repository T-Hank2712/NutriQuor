//
//  HomeView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HomeViewModel()

    private let bentoColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: - Header
                    BentoCard(accent: Color.nqPrimary, style: .tinted, padding: 20) {
                        HStack(alignment: .center, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Xin chào")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundStyle(.secondary)
                                Text("\(appState.profile?.lastName ?? "") \(appState.profile?.firstName ?? "Người dùng")")
                                    .font(.system(size: 30, weight: .black, design: .rounded))
                                    .foregroundStyle(.primary)
                                    .lineLimit(2)

                                Text("Theo dõi thành phần, phụ gia và dinh dưỡng trong từng lần quét.")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundStyle(.secondary)
                                    .lineSpacing(3)
                            }

                            Spacer(minLength: 10)

                            ZStack {
                                RoundedRectangle(cornerRadius: .smallRadius, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.nqPrimary, Color.nqInfo],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .smallRadius, style: .continuous)
                                            .stroke(Color.white.opacity(0.28), lineWidth: 1)
                                    )

                                Image(systemName: "heart.text.square.fill")
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.top, 8)
                    
                    // MARK: - Stats Section
                    VStack(alignment: .leading, spacing: 14) {
                        SectionLabel(text: "THỐNG KÊ HÔM NAY")
                        
                        LazyVGrid(columns: bentoColumns, spacing: 14) {
                            CountScansCard(count: viewModel.todayScanCount)
                            IndexCard()
                        }
                    }
                    
                    // MARK: - Insight
                    VStack(alignment: .leading, spacing: 14) {
                        SectionLabel(text: "GỢI Ý CHO BẠN")
                        if let daily = viewModel.daily {
                            InsightCard(item: daily)
                        } else {
                            BentoCard(accent: Color("ColorPrimary"), style: .plain) {
                                VStack(alignment: .leading, spacing: 12) {
                                    SkeletonLine(height: 16, width: 190)
                                    SkeletonLine(height: 12)
                                    SkeletonLine(height: 12, width: 240)
                                }
                            }
                        }
                    }
                    
                    // MARK: - Recent Scans
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            SectionLabel(text: "LỊCH SỬ QUÉT GẦN ĐÂY")
                            Spacer()
                            Button {
                                // view all
                            } label: {
                                Text("Xem tất cả")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color("ColorPrimary"))
                            }
                        }
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.scanHistory) { item in
                                NavigationLink {
                                    AnalystView(product: item.product, onDismiss: {})
                                } label: {
                                    HomeHistoryItem(record: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }.task {
                viewModel.updateUserId(appState.user?.id)
                viewModel.scanCountToday()
                viewModel.loadTodayScanHistory()
                
                await viewModel.loadDailyFeature()
            }
            .background(Color("Background"))
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView().environmentObject(AppState())
}
