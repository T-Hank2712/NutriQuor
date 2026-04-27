//
//  SearchDetailView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct SearchDetailView: View {
    var data: SearchDTO
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ZStack(alignment: .bottomTrailing) {
                    
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .fill(Color.black)
                        .frame(width: 140, height: 140)
                    
                    Text("AVOID")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(.smallRadius)
                        .offset(x: 10, y: 10)
                }
                
                Text(data.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                HStack{
                    ForEach([data.code, data.type].compactMap { $0 }, id: \.self) { tag in
                        Tag(text: tag, color: .green)
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("What is it?")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(data.description)
                        .foregroundColor(.secondary)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Image(systemName: "shield.fill")
                            .foregroundColor(.green)
                        
                        Text("Health Impact")
                            .font(.headline)
                    }
                    
                    ForEach(data.effects) { effect in
                        ImpactCard(
                            icon: "",
                            title: effect.title,
                            text: "",
                            color: .green
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(.cardRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(Color.gray.opacity(.opacityLight), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(.opacityLight), radius: 6, x: 0, y: 3)
                
                VStack(alignment: .leading){
                    Text("Commonly Found In")
                        .font(.headline)
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 12
                    ) {
                        ForEach(data.found_in, id: \.id) { found in
                            FoundItem(
                                icon: "cup.and.saucer.fill",
                                title: found.name
                            )
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }
    }
}
#Preview {
    SearchDetailView(data: SearchDTO(id: "1", name: "Test", code: "E123", image: "test", description: "Test", effects: [HealthEffect(id: 1, title: "Test")], found_in: [FoodCategory(id: 1, name: "Test")], type: "Test"))
}
