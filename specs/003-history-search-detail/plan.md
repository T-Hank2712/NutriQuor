# Implementation Plan: Lịch Sử, Tìm Kiếm Và Chi Tiết

**Branch**: `003-history-search-detail` | **Date**: 2026-07-20 | **Spec**: `spec.md`

**Input**: Đặc tả chức năng từ `/specs/003-history-search-detail/spec.md`

## Summary

Triển khai và kiểm chứng history, history detail, search và knowledge detail screens chỉ dựa trên ViFood-API. App hiển thị dữ liệu public backend trả về và không truy cập trực tiếp MongoDB, Neo4j hoặc S3.

## Technical Context

**Language/Version**: Swift  
**Primary Dependencies**: SwiftUI, URLSession, async/await  
**Storage**: Dữ liệu do Backend cung cấp; chỉ dùng in-memory image cache nếu cần  
**Testing**: Xcode build, API giả lập hoặc kiểm tra thủ công luồng navigation, rà soát contract decode  
**Target Platform**: iOS  
**Project Type**: Ứng dụng di động  
**Performance Goals**: List và detail vẫn phản hồi tốt trong lúc async load.  
**Constraints**: Chỉ gọi Backend API; chỉ mở detail khi có id hợp lệ; không hiển thị dữ liệu thô/nội bộ trong UI.  
**Scale/Scope**: Scan history của người dùng hiện tại, history detail, search và detail views.

## Constitution Check

- Backend API là ranh giới duy nhất khi chạy: PASS.
- UI hiển thị sự thật từ backend: PASS.
- Không hiển thị JSON thô/internal metadata cho người dùng: REQUIRED.
- Chỉ gọi detail khi có id: REQUIRED.

## AI4SE Execution Flow

```text
Ngữ cảnh Sys-docs về history/search/detail
  -> root + NutriQuor AGENTS.md
  -> spec/plan/tasks của Spec Kit này
  -> iOS API integration + history verification skills
  -> Codex triển khai
  -> Xcode build + thủ công list/detail/search verification
  -> con người xác nhận
  -> ghi evidence AI4SE
```

## Verification Strategy

- Chạy Xcode build sau khi có thay đổi code.
- Rà soát `ScanHistoryAPI`, `ScanHistoryService`, `ScanHistory`, `HistoryViewModel`, `HistoryView`, `HistoryDetailView`.
- Rà soát `SearchAPI`, `SearchService`, `SearchDTO`, `SearchDetailDTO`, `SearchNutritionViewModel`, `SearchView`, `SearchDetailView`.
- Xác nhận `image_url` được dùng để hiển thị ảnh và `image_ref` không bị xem là truy cập storage trực tiếp.
- Xác nhận search/detail không gọi URL ngoài Backend API.

## Project Structure

```text
NutriQuor/Features
NutriQuor/ViewModels
NutriQuor/Core/Services
NutriQuor/API
NutriQuor/Models
```

**Structure Decision**: Dùng các thư mục history/search hiện có và shared API client. Không thêm client storage/database trực tiếp.

## Complexity Tracking

Không có vi phạm constitution.
