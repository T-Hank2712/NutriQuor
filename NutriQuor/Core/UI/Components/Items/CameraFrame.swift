import SwiftUI

struct CameraFrame: View {
    let frameHeight: CGFloat
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.primary, lineWidth: 2)
            .frame(height: frameHeight)
    }
}
#Preview {
    CameraFrame(frameHeight: 550)
}
