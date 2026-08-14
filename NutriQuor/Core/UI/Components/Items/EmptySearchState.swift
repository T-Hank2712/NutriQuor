//
//  EmptySearchState.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct EmptySearchState: View {
    let isSearching: Bool

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color("ColorPrimary").opacity(0.1))
                    .frame(width: 72, height: 72)
                Image(systemName: isSearching ? "magnifyingglass" : "tray")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(Color("ColorPrimary").opacity(0.6))
            }

            VStack(spacing: 4) {
                Text(isSearching ? "Không tìm thấy kết quả phù hợp" : "Chưa có nội dung để hiển thị")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                Text(isSearching ? "Thử từ khóa khác nhé" : "Nội dung sẽ xuất hiện khi sẵn sàng")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

#Preview {
    VStack(spacing: 24) {
        EmptySearchState(isSearching: false)
        EmptySearchState(isSearching: true)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
