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
                    Tag(text: "Vitamin", color: Color.green)
                    Tag(text: "Health", color: Color.blue)
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
                            text: "Hihi",
                            color: .green
                        )
                    }
                }
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
    SearchDetailView(data: SearchDTO(id: "1", name: "Test", code: "E123", image: "test", description: "Test", effects: [], found_in: [], type: "Test"))
}
