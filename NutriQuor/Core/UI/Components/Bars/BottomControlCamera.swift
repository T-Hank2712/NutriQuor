//
//  BottomControlCamera.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct BottomControlCamera: View {
    var onCapture: () -> Void = {}
    
    var body: some View {
        HStack{
            CircleButton(icon: "photo.fill")
            Spacer()
            CaptureButton()
                .onTapGesture {
                    onCapture()
                }
            Spacer()
            CircleButton(icon: "arrow.trianglehead.2.clockwise")
        }
    }
}

#Preview {
    BottomControlCamera()
}
