//
//  CameraImageProcessor.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import UIKit

struct CameraImageProcessor {

    static func crop(
        image: UIImage,
        previewSize: CGSize,
        cropRect: CGRect
    ) -> UIImage {

        let fixed = image.fixedOrientation()

        guard let cgImage = fixed.cgImage else {
            return image
        }

        let scaleX = CGFloat(cgImage.width) / previewSize.width
        let scaleY = CGFloat(cgImage.height) / previewSize.height

        let rect = CGRect(
            x: cropRect.origin.x * scaleX,
            y: cropRect.origin.y * scaleY,
            width: cropRect.width * scaleX,
            height: cropRect.height * scaleY
        )

        guard let cropped = cgImage.cropping(to: rect) else {
            return fixed
        }

        return UIImage(cgImage: cropped, scale: fixed.scale, orientation: .up)
    }

}

