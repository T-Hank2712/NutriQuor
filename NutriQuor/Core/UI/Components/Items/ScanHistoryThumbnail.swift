import SwiftUI
import UIKit

struct ScanHistoryThumbnail: View {
    let imageRef: String?
    let imageUrl: String?
    let size: CGFloat

    @State private var image: UIImage?
    @State private var isLoading = false

    private var url: URL? {
        guard let imageUrl,
              !imageUrl.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }

        return URL(string: imageUrl)
    }

    private var cacheKey: String? {
        if let imageRef,
           !imageRef.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return imageRef
        }

        return imageUrl
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color("ColorPrimary").opacity(0.12))

            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
                    .tint(Color("ColorPrimary"))
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
        .task(id: imageUrl) {
            await loadImage()
        }
    }

    private var placeholder: some View {
        Image(systemName: "photo.on.rectangle.angled")
            .font(.system(size: size * 0.34, weight: .semibold))
            .foregroundStyle(Color("ColorPrimary"))
    }

    private func loadImage() async {
        guard let url else {
            image = nil
            isLoading = false
            return
        }

        let key = cacheKey ?? url.absoluteString
        if let cachedImage = ImageMemoryCache.shared.image(forKey: key) {
            image = cachedImage
            isLoading = false
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let loadedImage = UIImage(data: data) else {
                return
            }

            ImageMemoryCache.shared.setImage(loadedImage, forKey: key)
            image = loadedImage
        } catch {
            image = nil
        }
    }
}

#Preview {
    ScanHistoryThumbnail(imageRef: nil, imageUrl: nil, size: 64)
}

private final class ImageMemoryCache {
    static let shared = ImageMemoryCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
