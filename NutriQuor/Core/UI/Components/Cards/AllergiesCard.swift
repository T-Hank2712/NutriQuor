//
//  AllergiesCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct AllergiesCard: View {
    let allergies: [Allergy]

    var onAdd: () -> Void
    var onDelete: (Allergy) -> Void

    @State private var showDeleteAlert = false
    @State private var selectedAllergy: Allergy?

    private let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 10, alignment: .leading)
    ]

    var body: some View {

        BentoCard(accent: Color("AccentOrange"), style: .tinted, padding: 16) {
            VStack(alignment: .leading, spacing: 16) {

                HStack(spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("AccentOrange").opacity(0.14))
                            .frame(width: 38, height: 38)

                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color("AccentOrange"))
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Dị ứng")
                            .font(.headline.weight(.bold))

                        Text("Các thành phần cần được cảnh báo khi phân tích nhãn")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer(minLength: 0)

                    Button {
                        onAdd()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 34, height: 34)
                            .background(Color("AccentOrange"))
                            .clipShape(Circle())
                            .shadow(color: Color("AccentOrange").opacity(0.22), radius: 8, y: 4)
                    }
                    .accessibilityLabel("Thêm dị ứng")
                }

                if allergies.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Chưa có dị ứng nào")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))

                        Text("Thêm dị ứng để hệ thống ưu tiên cảnh báo khi sản phẩm có thành phần liên quan.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("AccentOrange").opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color("AccentOrange").opacity(0.18), lineWidth: 1)
                    }
                } else {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                        ForEach(allergies) { allergy in
                            Button {
                                selectedAllergy = allergy
                                showDeleteAlert = true
                            } label: {
                                TagWithXmark(text: allergy.name, color: Color("AccentOrange"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }

        // MARK: - Delete Alert
        .alert("Xóa dị ứng?", isPresented: $showDeleteAlert) {

            Button("Hủy", role: .cancel) {}

            Button("Xóa", role: .destructive) {
                if let allergy = selectedAllergy {
                    onDelete(allergy)
                }
            }

        } message: {
            Text("Bạn có chắc chắn muốn xóa dị ứng này khỏi hồ sơ không?")
        }
    }
}

#Preview {
    AllergiesCard(
        allergies: [
            Allergy(id: "1", name: "Đậu phộng"),
            Allergy(id: "2", name: "Gluten")
        ],
        onAdd: {},
        onDelete: { _ in }
    )
}
