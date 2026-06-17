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
        
        VStack(alignment: .leading, spacing: 14) {
            
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(Color(.colorPrimary))
                
                Text("INSIGHT OF THE DAY")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.white))
            }
            
            Text(
                item.code?.isEmpty == false
                ? "\(item.name) (\(item.code!))"
                : item.name
            )
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text(item.description ?? "")
                .foregroundColor(.white)
            
            NavigationLink {
                SearchDetailView(id: item.id)
            } label: {
                Text("LEARN MORE")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(.colorPrimary))
                    .foregroundColor(.black)
                    .cornerRadius(.smallRadius)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.black, Color(.colorPrimary).opacity(.opacityStrong)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(.cardRadius)
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
