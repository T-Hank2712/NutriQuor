//
//  CaptureButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct CaptureButton: View {
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color.white.opacity(.opacityLight))
                .frame(width:90,height:90)
                .overlay(
                    Circle()
                        .stroke(.black, lineWidth: 2)
                )
            
            Circle()
                .fill(Color.white)
                .frame(width:70,height:70)
                .overlay(
                    Circle()
                        .stroke(Color(.primary), lineWidth: 2)
                )
        }
    }
}

#Preview {
    CaptureButton()
}
