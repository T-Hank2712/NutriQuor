import SwiftUI

extension View {
    func hideBottomBarOnDetail() -> some View {
        modifier(HideBottomBarOnDetailModifier())
    }

    func restoreBottomBarOnRoot() -> some View {
        modifier(RestoreBottomBarOnRootModifier())
    }
}

private struct HideBottomBarOnDetailModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar(.visible, for: .tabBar)
    }
}

private struct RestoreBottomBarOnRootModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar(.visible, for: .tabBar)
    }
}
