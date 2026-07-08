//
//  CameraButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/1/26.
//

import SwiftUI

struct CameraButton: View {
    @State private var activeRoute: CameraRoute?

    var body: some View {
        VStack {
            Spacer()

            Button {
                activeRoute = .camera
            } label: {
                Image(systemName: "camera.fill")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64)
                    .background(
                        Circle()
                            .fill(Color(.colorPrimary))
                            .shadow(radius: 10)
                    )
            }
            .offset(y: -30)
            .fullScreenCover(item: $activeRoute) { route in
                switch route {
                case .camera:
                    CameraView { product in
                        activeRoute = .analysis(product)
                    }
                case .analysis(let product):
                    AnalystView(product: product) {
                        activeRoute = nil
                    }
                }
            }
        }
    }
}

private enum CameraRoute: Identifiable {
    case camera
    case analysis(Product)

    var id: String {
        switch self {
        case .camera:
            return "camera"
        case .analysis:
            return "analysis"
        }
    }
}

#Preview {
    CameraButton()
}
