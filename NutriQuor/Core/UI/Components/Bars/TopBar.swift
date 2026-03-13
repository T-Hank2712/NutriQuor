//
//  TopBar.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct TopBar: View {
    let title: String
    var body: some View {
        HStack {
            
            Image(systemName: "arrow.left")
                .font(.title3)
            
            Spacer()
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "square.and.arrow.up")
                .font(.title3)
        }
        .padding(.top, 10)
    }
}

#Preview {
    TopBar(title: "Detail")
}
