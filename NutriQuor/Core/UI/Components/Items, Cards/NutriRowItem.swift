//
//  NutriRowItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//

import SwiftUI

struct NutriRowItem: View {
//    let record: Nutrition
    let record: NutriText
    var body: some View {
        HStack{
//            Text(record.name)
//            Spacer()
//            Text(String(format: "%.2f \(record.unit)", record.value))
            Text(record.text)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.separator)),
            alignment: .bottom
        ).padding(.vertical, 5).padding(.horizontal, 10)
    }
}

#Preview {
    NutriRowItem(/*record: Nutrition(name: "Calories", unit: "kcal", value: 100)*/
        record: NutriText(text: "Calories"))
}
