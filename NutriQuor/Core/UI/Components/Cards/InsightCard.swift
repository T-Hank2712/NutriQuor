//
//  InsightCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct InsightCard: View {
    
    var item: SearchDTO
    
    var body: some View {
        
        BentoCard(accent: Color("ColorPrimary"), style: .tinted, padding: 18) {
            VStack(alignment: .leading, spacing: 14) {
            
                HStack {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(Color("ColorPrimary"))
                
                    Text("GỢI Ý HÔM NAY")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Heading").opacity(0.75))
                }
            
                Text(
                    item.code?.isEmpty == false
                    ? "\(item.name) (\(item.code!))"
                    : item.name
                )
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("Heading"))
            
                Text(item.description ?? "")
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            
                NavigationLink {
                    SearchDetailView(id: item.id)
                } label: {
                    Text("XEM CHI TIẾT")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 9)
                        .background(Color("ColorPrimary"))
                        .foregroundColor(.white)
                        .cornerRadius(.smallRadius)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    InsightCard(
        item: SearchDTO(
            id: "1",
            name: "Orange GGN",
            code: "E111",
            description: "Synthetic orange food coloring formerly used in beverages and confectionery. It has been banned in many countries due to safety concerns.",
            type: "Additive"
        )
    )
}
