//
//  CameraButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/1/26.
//

import SwiftUI

struct CameraButton: View {
    @EnvironmentObject private var appState: AppState

    @State private var activeRoute: CameraRoute?
    @State private var detailStack: [FullScreenDetailRoute] = []

    var body: some View {
        VStack {
            Spacer()

            Button {
                detailStack.removeAll()
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
                        detailStack.removeAll()
                        appState.notifyScanHistoryChanged()
                        activeRoute = .analysis(product)
                    }
                case .analysis(let product):
                    ZStack {
                        NavigationStack {
                            AnalystView(product: product, showsDismissButton: true) {
                                detailStack.removeAll()
                                activeRoute = nil
                            }
                        }
                        .fullScreenDetailNavigator(
                            FullScreenDetailNavigator(
                                push: { view in
                                    detailStack.append(
                                        FullScreenDetailRoute(view: view)
                                    )
                                },
                                pop: {
                                    guard !detailStack.isEmpty else { return }
                                    detailStack.removeLast()
                                }
                            )
                        )

                        ForEach(Array(detailStack.enumerated()), id: \.element.id) { index, route in
                            route.view
                                .id(route.id)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("Background"))
                                .ignoresSafeArea()
                                .zIndex(Double(10 + index))
                                .transition(
                                    .asymmetric(
                                        insertion: .move(edge: .trailing),
                                        removal: .move(edge: .trailing)
                                    )
                                )
                        }
                    }
                    .animation(.easeInOut(duration: 0.26), value: detailStack.count)
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
