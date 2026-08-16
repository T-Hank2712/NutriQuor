import SwiftUI

struct FullScreenDetailNavigator {
    let push: (AnyView) -> Void
    let pop: () -> Void
}

struct FullScreenDetailLink<Label: View, Destination: View>: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.fullScreenDetailNavigator) private var localNavigator

    @ViewBuilder let destination: () -> Destination
    @ViewBuilder let label: () -> Label

    var body: some View {
        Button {
            if let localNavigator {
                localNavigator.push(
                    AnyView(
                        NavigationStack {
                            destination()
                                .navigationBarBackButtonHidden(true)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button {
                                            localNavigator.pop()
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundStyle(.primary)
                                        }
                                    }
                                }
                        }
                    )
                )
            } else {
                appState.pushFullScreenDetail {
                    NavigationStack {
                        destination()
                            .navigationBarBackButtonHidden(true)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        appState.popFullScreenDetail()
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(.primary)
                                    }
                                }
                            }
                    }
                }
            }
        } label: {
            label()
        }
        .buttonStyle(.plain)
    }
}

private struct FullScreenDetailNavigatorKey: EnvironmentKey {
    static let defaultValue: FullScreenDetailNavigator? = nil
}

extension EnvironmentValues {
    var fullScreenDetailNavigator: FullScreenDetailNavigator? {
        get { self[FullScreenDetailNavigatorKey.self] }
        set { self[FullScreenDetailNavigatorKey.self] = newValue }
    }
}

extension View {
    func fullScreenDetailNavigator(_ navigator: FullScreenDetailNavigator?) -> some View {
        environment(\.fullScreenDetailNavigator, navigator)
    }
}
