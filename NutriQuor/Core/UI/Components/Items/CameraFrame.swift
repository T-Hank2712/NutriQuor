import SwiftUI

struct CameraFrame: View {
    let frameHeight: CGFloat
    var body: some View {
        
        RoundedRectangle(cornerRadius: .cardRadius)
            .stroke(Color.colorPrimary, lineWidth: 2)
            .frame(height: frameHeight)
    }
}
#Preview {
    CameraFrame(frameHeight: 550)
}
