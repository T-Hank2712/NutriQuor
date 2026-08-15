import SwiftUI

struct ScanHistoryThumbnail: View {
    let imageUrl: String?
    let size: CGFloat

    private var url: URL? {
        guard let imageUrl,
              !imageUrl.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }

        return URL(string: imageUrl)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color("ColorPrimary").opacity(0.12))

            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(Color("ColorPrimary"))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: .cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.primary.opacity(0.06), lineWidth: 1)
        )
    }

    private var placeholder: some View {
        Image(systemName: "photo.on.rectangle.angled")
            .font(.system(size: size * 0.34, weight: .semibold))
            .foregroundStyle(Color("ColorPrimary"))
    }
}

#Preview {
    ScanHistoryThumbnail(imageUrl: nil, size: 64)
}
