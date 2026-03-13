//
//  SearchDetailView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct SearchDetailView: View {
    var body: some View {
        TopBar(title: "Detail").padding(16)
        ScrollView{
            VStack(spacing: 20){
                ZStack(alignment: .bottomTrailing) {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .frame(width: 140, height: 140)
                    
                    Text("AVOID")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .offset(x: 10, y: 10)
                }
                
                Text("Vitamin D")
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
                    
                    Text("Aspartame is a low-calorie artificial sweetener used as a sugar substitute in many foods and beverages. It is approximately 200 times sweeter than sucrose but has a negligible caloric effect.")
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Image(systemName: "shield.fill")
                            .foregroundColor(.green)
                        
                        Text("Health Impact")
                            .font(.headline)
                    }
                    
                    ImpactCard(
                        icon: "flame.fill",
                        title: "Weight Loss",
                        text: "May trigger insulin response despite being calorie-free.",
                        color: .orange
                    )
                    
                    ImpactCard(
                        icon: "brain.head.profile",
                        title: "Neurological Effects",
                        text: "Some studies link long-term use to headaches and dizziness.",
                        color: .red
                    )
                    
                    ImpactCard(
                        icon: "cross.case.fill",
                        title: "PKU Warning",
                        text: "Contains phenylalanine. Dangerous for PKU patients.",
                        color: .blue
                    )
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
                
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
                        
                        FoundItem(icon: "cup.and.saucer.fill", title: "Diet Sodas")
                        FoundItem(icon: "circle.grid.2x2.fill", title: "Sugar-free Gum")
                        FoundItem(icon: "leaf.fill", title: "Light Yogurts")
                        FoundItem(icon: "pills.fill", title: "Tablets")
                    }
                }
            }.padding(.horizontal, 16)
        }
    }
}
#Preview {
    SearchDetailView()
}
