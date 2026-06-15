//
//  InsightCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct InsightCard: View {
    
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
            
            Text("Red 40 (E129)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Used in candies and dairy products. Recent studies link it to hyperactivity in children. Check for 'Allura Red' on your labels.")
                .foregroundColor(.white)
            
            NavigationLink {
                SearchDetailView(id: "1")
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
    InsightCard()
}
