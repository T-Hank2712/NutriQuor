//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//

import SwiftUI

struct AnalystView: View {
    let nutriItem: History
    let onDismiss: () -> Void
    
    @State private var selectedRow: NutriText?
    
    var body: some View {
        ZStack {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Product
                    ProductCard()
                    
                    Text("Nutrition")
                        .font(.title2)
                        .bold()
                    //MARK: - Nutrient
                    HStack{
                        NutrientCard(title: "PROTEIN", value: "8g", color: .red, icon: "drop.fill")
                        NutrientCard(title: "CARBS", value: "12g", color: .blue, icon: "drop.fill")
                        NutrientCard(title: "FAT", value: "14g", color: .green, icon: "drop.fill")
                    }
                    
                    
                    // MARK: - Alert
                    AlertCard(color: .red, title: "Warning", description: "Không giành cho trẻ em dưới 3 tuổi.")
                    AlertCard(color: .orange, title: "Allergy", description: "Sản phẩm có chứa Sữa.")
                    
                    // MARK: - Ingredients
                    Text("Contains")
                        .font(.title2)
                        .bold()
                    HStack(spacing: 20){
                        ContainCard(title: "Ingredients", good: "6 Healthy", bad: "2 To Limit", color: .green)
                        ContainCard(title: "Additives", good: "", bad: "6 adds", color: .orange)
                    }
                    Button {
                        print("View All")
                    } label: {
                        HStack {
                            Image(systemName: "ellipsis.circle")
                            Text("View All Ingredients")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                    // MARK: - Options
                    Text("Options")
                        .font(.title2)
                        .bold()
                    
                    OptionCard(title: "Thêm vào yêu thích",
                               icon: "heart",
                               color: Color(.primary))
                    
                    OptionCard(title: "Chia sẻ",
                               icon: "square.and.arrow.up",
                               color: Color(.primary))
                }
                .padding(.horizontal, 20)
                
            }
        }
    }
}


// MARK: - Popup UI


#Preview {
    AnalystView(nutriItem: History(
        image: Image("Example"),
        title: "Bánh quy ABC",
        warning: "Nhiều đường",
        score: "Xấu",
        time: Calendar.current.date(
            from: DateComponents(
                year: 2025,
                month: 1,
                day: 24,
                hour: 21,
                minute: 04
            )
        )!
        ),
        onDismiss: {}
    )
}
