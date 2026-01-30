//
//  ImageCropHelper.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import UIKit

struct ImageCropHelper {
    /// Crop ảnh theo khung preview với độ chính xác cao
    /// - Parameters:
    ///   - image: Ảnh gốc cần crop
    ///   - previewSize: Kích thước của preview view
    ///   - cropRect: Vùng crop trên preview
    /// - Returns: Ảnh đã được crop
    static func cropImage(
        _ image: UIImage,
        previewSize: CGSize,
        cropRect: CGRect
    ) -> UIImage {

        let normalizedImage = image.fixedOrientation()

        guard let cgImage = normalizedImage.cgImage else {
            return image
        }

        let imageWidth = CGFloat(cgImage.width)
        let imageHeight = CGFloat(cgImage.height)
        let imageAspect = imageWidth / imageHeight
        let previewAspect = previewSize.width / previewSize.height

        // resizeAspectFill
        var scale: CGFloat
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0

        if imageAspect > previewAspect {
            // Ảnh rộng hơn
            scale = imageHeight / previewSize.height
            let visibleWidth = previewSize.width * scale
            offsetX = (imageWidth - visibleWidth) / 2
        } else {
            // Ảnh cao hơn
            scale = imageWidth / previewSize.width
            let visibleHeight = previewSize.height * scale
            offsetY = (imageHeight - visibleHeight) / 2
        }

        let imageCropRect = CGRect(
            x: offsetX + cropRect.origin.x * scale,
            y: offsetY + cropRect.origin.y * scale,
            width: cropRect.width * scale,
            height: cropRect.height * scale
        )

        guard let croppedCGImage = cgImage.cropping(to: imageCropRect) else {
            return normalizedImage
        }

        return UIImage(
            cgImage: croppedCGImage,
            scale: normalizedImage.scale,
            orientation: .up
        )
    }

}

