# Implementation Plan: Hiển Thị Kết Quả Phân Tích

**Branch**: `006-analysis-result-display` | **Date**: 2026-07-12 | **Spec**: `spec.md`

**Input**: Đặc tả chức năng từ `/specs/006-analysis-result-display/spec.md`

## Summary

Xây dựng và kiểm chứng màn hiển thị kết quả phân tích nhãn thực phẩm trên ứng dụng iOS. Feature này bắt đầu từ `Product` public result đã decode và chỉ chịu trách nhiệm render dữ liệu, grouping section, fallback optional field và detail navigation an toàn.

## Technical Context

**Language/Version**: Swift  
**Primary Dependencies**: SwiftUI, NavigationStack, URLSession-backed image/loading components hiện có  
**Storage**: Không lưu dữ liệu mới; dùng `image_ref`/`image_url` public nếu Backend API trả về  
**Testing**: Xcode build, SwiftUI preview/sample product, contract decode review, kiểm thử thủ công result UI  
**Target Platform**: iOS  
**Project Type**: Ứng dụng di động  
**Performance Goals**: Result screen cuộn mượt, không block UI khi render nhiều item.  
**Constraints**: Không gọi Builder/AIaaS/S3/MongoDB/Neo4j; không tự sinh dữ liệu thiếu; không hiển thị debug/internal payload.  
**Scale/Scope**: Một màn kết quả phân tích và danh sách thành phần/phụ gia/detail link từ result.

## Constitution Check

- App chỉ nhận dữ liệu public từ Backend API: PASS.
- Result UI không tự suy luận dữ liệu không có trong response: REQUIRED.
- Detail navigation chỉ dùng id public hợp lệ: REQUIRED.
- Chức năng phải kiểm thử được bằng build, sample product hoặc luồng scan/history thủ công: REQUIRED.

## AI4SE Execution Flow

```text
Ngữ cảnh Sys-docs về result contract/data-model
  -> root + NutriQuor AGENTS.md
  -> spec/plan/tasks của Spec Kit này
  -> iOS API integration + contract sync + UI quality skills
  -> Codex rà model/result UI/navigation hiện có
  -> Codex triển khai hoặc chỉnh sửa
  -> Xcode build + contract/UI/manual verification
  -> con người xác nhận
  -> ghi evidence AI4SE
```

## Verification Strategy

- Chạy Xcode build sau khi có thay đổi code.
- Kiểm tra `Product` decode các field public: `product_name`, `ingredients`, `additives`, `nutritions`, `ingredient_items`, `additive_items`, `nutrient_items`, `warning`, `manufacturer`, `mfg_date`, `expiry_date`, `net_weight`, `origin`, `image_ref`, `image_url`.
- Kiểm tra `AnalystView` render đúng section: hero, dinh dưỡng, cảnh báo, thành phần/phụ gia và thông tin sản phẩm.
- Kiểm tra `ContainListView` hiển thị fallback list text và detail id an toàn.
- Kiểm tra `CameraButton` hoặc luồng gọi result chỉ mở `AnalystView(product:)` sau khi có `Product` thành công.
- Xác nhận không có direct URL Builder/AIaaS/S3/MongoDB/Neo4j hoặc raw JSON/internal error trong result UI.

## Project Structure

```text
NutriQuor/Models
NutriQuor/Features/ScanNutri
NutriQuor/Core/UI/Components
```

**Structure Decision**: Dùng các đường dẫn hiện có: `Models/Product.swift`, `Models/APIResponse.swift`, `Features/ScanNutri/AnalystView.swift`, `Features/ScanNutri/ContainListView.swift`, `Core/UI/Components/Buttons/CameraButton.swift`. Không tạo service mới cho feature hiển thị.

## Complexity Tracking

Không có vi phạm constitution.
