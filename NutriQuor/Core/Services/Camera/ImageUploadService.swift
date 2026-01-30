//
//  ImageUploadService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/1/26.
//

import UIKit
import Foundation

// MARK: - Response Models
struct OCRResponse: Codable {
    let success: Bool
    let textRegions: Int?
    let rows: Int?
    let results: [OCRRow]?
    let fullText: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case textRegions = "text_regions"
        case rows
        case results
        case fullText = "full_text"
    }
}

struct OCRRow: Codable, Identifiable {
    let rowNumber: Int
    let text: String
    let items: [OCRItem]?
    
    var id: Int { rowNumber }
    
    enum CodingKeys: String, CodingKey {
        case rowNumber = "row_number"
        case text
        case items
    }
}

struct OCRItem: Codable {
    let text: String
    let confidence: Double?
}

// Model để hiển thị kết quả
struct OCRData {
    let fullText: String
    let rows: [OCRRow]
    let nutritionInfo: [String: String]
}

// MARK: - Service
class ImageUploadService {
    static let shared = ImageUploadService()
    
    private let uploadURL = "http://api-storage.dvxuanbac.com:8000/api/upload"
    private let ocrURL = "http://api-ocr.dvxuanbac.com:3001/ocr"
    
    private init() {}
    
    func uploadImage(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw UploadError.invalidImage
        }
        
        guard let url = URL(string: uploadURL) else {
            throw UploadError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createMultipartBody(imageData: imageData, boundary: boundary, filename: "image.jpg")
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UploadError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw UploadError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // Parse response để lấy URL ảnh đã upload
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let imageUrl = json["url"] as? String {
            return imageUrl
        }
        
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    // MARK: - Upload và OCR
    func uploadAndAnalyzeImage(_ image: UIImage) async throws -> OCRData {
        // Bước 1: Upload ảnh lên cloud
        let imageUrl = try await uploadImage(image)
        print("✅ Đã upload ảnh: \(imageUrl)")
        
        // Bước 2: Gọi API OCR với ảnh binary (download từ cloud)
        let ocrData = try await analyzeImageWithOCR(image: image)
        print("✅ Đã nhận kết quả OCR")
        
        return ocrData
    }
    
    // MARK: - OCR API
    private func analyzeImageWithOCR(image: UIImage) async throws -> OCRData {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw UploadError.invalidImage
        }
        
        guard let url = URL(string: ocrURL) else {
            throw UploadError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Gửi file binary qua multipart form-data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createOCRMultipartBody(imageData: imageData, boundary: boundary, filename: "image.jpg")
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UploadError.invalidResponse
        }
        
        // Debug response
        if let responseString = String(data: data, encoding: .utf8) {
            print("📥 OCR Response: \(responseString)")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw UploadError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // Parse OCR response
        let decoder = JSONDecoder()
        let ocrResponse = try decoder.decode(OCRResponse.self, from: data)
        
        guard ocrResponse.success else {
            throw UploadError.ocrError(message: "OCR không thành công")
        }
        
        guard let rows = ocrResponse.results else {
            throw UploadError.ocrError(message: "Không nhận được dữ liệu OCR")
        }
        
        let nutritionInfo = parseNutritionInfo(from: rows)
        
        return OCRData(
            fullText: ocrResponse.fullText ?? "",
            rows: rows,
            nutritionInfo: nutritionInfo
        )
    }
    
    // Parse thông tin dinh dưỡng
    private func parseNutritionInfo(from rows: [OCRRow]) -> [String: String] {
        var info: [String: String] = [:]
        
        for row in rows {
            let text = row.text.lowercased()
            
            if text.contains("năng lượng") || text.contains("energy") {
                info["energy"] = row.text
            }
            else if text.contains("chất béo") || (text.contains("fat") && !text.contains("saturated")) {
                info["fat"] = row.text
            }
            else if text.contains("carbohydrat") {
                info["carbs"] = row.text
            }
            else if text.contains("protein") || text.contains("chất đạm") {
                info["protein"] = row.text
            }
            else if text.contains("đường") || text.contains("sugar") {
                info["sugar"] = row.text
            }
            else if text.contains("natri") || text.contains("sodium") {
                info["sodium"] = row.text
            }
        }
        
        return info
    }
    
    private func createMultipartBody(imageData: Data, boundary: String, filename: String) -> Data {
        var body = Data()
        
        // Add image field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // End boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    private func createOCRMultipartBody(imageData: Data, boundary: String, filename: String) -> Data {
        var body = Data()
        
        // Add file field for OCR
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // End boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

// MARK: - Error Handling
enum UploadError: LocalizedError {
    case invalidImage
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case ocrError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "Không thể chuyển đổi ảnh"
        case .invalidURL:
            return "URL không hợp lệ"
        case .invalidResponse:
            return "Phản hồi từ server không hợp lệ"
        case .serverError(let code):
            return "Lỗi server: \(code)"
        case .ocrError(let message):
            return "Lỗi OCR: \(message)"
        }
    }
}
