# Implementation Plan: Phân Tích Ảnh Nhãn

**Branch**: `002-scan-analysis` | **Date**: 2026-08-13 | **Spec**: `spec.md`

**Input**: Đặc tả chức năng từ `/specs/002-scan-analysis/spec.md`

## Summary

Xây dựng và kiểm chứng chọn ảnh, xem trước ảnh, multipart upload và hiển thị kết quả thông qua ViFood-API. App không được biết chi tiết nội bộ của Builder, AIaaS, S3, MongoDB hoặc Neo4j.

## Technical Context

**Language/Version**: Swift  
**Primary Dependencies**: SwiftUI, Photos/Camera APIs, URLSession multipart upload  
**Storage**: Ảnh cục bộ tạm thời; `image_ref`/`image_url` do Backend cung cấp để hiển thị metadata ảnh trong result/history  
**Testing**: Xcode build, API giả lập hoặc luồng scan thủ công, rà soát contract decode  
**Target Platform**: iOS  
**Project Type**: Ứng dụng di động  
**Performance Goals**: UI vẫn phản hồi tốt trong lúc chọn ảnh và upload.  
**Constraints**: Chỉ gọi `/products/extract`; không gọi trực tiếp service nội bộ; không tự tạo dữ liệu kết quả.  
**Scale/Scope**: Luồng scan một ảnh nhãn thực phẩm cho người dùng đã xác thực.

## Constitution Check

- Backend API là ranh giới duy nhất khi chạy: PASS.
- UI hiển thị sự thật từ backend: PASS.
- Luồng scan có xem trước ảnh, trạng thái đang xử lý, thành công và lỗi: REQUIRED.
- Chức năng phải kiểm thử được bằng build hoặc luồng thủ công: REQUIRED.

## AI4SE Execution Flow

```text
Ngữ cảnh Sys-docs về scan/API/data-model
  -> root + NutriQuor AGENTS.md
  -> spec/plan/tasks của Spec Kit này
  -> iOS API integration + contract sync skills
  -> Codex triển khai
  -> Xcode build + contract decode/thủ công scan verification
  -> con người xác nhận
  -> ghi evidence AI4SE
```

## Verification Strategy

- Chạy Xcode build sau khi có thay đổi code.
- Kiểm tra `ProductAPI` gửi multipart image đến Backend API `/products/extract`.
- Kiểm tra `ProductService`, `ScanNutriViewModel`, `Product`, `AnalyzeResponse` hoặc DTO liên quan khớp contract API hiện tại.
- Kiểm tra thủ công hoặc bằng response giả lập cho trạng thái đang xử lý, thành công, lỗi và UI kết quả theo nhóm.
- Xác nhận không có URL Builder/AIaaS/S3/MongoDB/Neo4j trực tiếp trong luồng scan của app.

## Project Structure

```text
NutriQuor/Features
NutriQuor/ViewModels
NutriQuor/Core/Services
NutriQuor/API
NutriQuor/Models
```

**Structure Decision**: Dùng các đường dẫn hiện có: `Features/ScanNutri`, `ViewModels/ScanNutriViewModel.swift`, `API/ProductAPI.swift`, `Core/Services/ProductService.swift`, `Models/Product.swift`.

## Complexity Tracking

Không có vi phạm constitution.
