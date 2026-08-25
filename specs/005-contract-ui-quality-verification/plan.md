# Implementation Plan: Kiểm Chứng Contract Và Chất Lượng UI

**Branch**: `005-contract-ui-quality-verification` | **Date**: 2026-08-25 | **Spec**: `spec.md`

**Input**: Đặc tả chức năng từ `/specs/005-contract-ui-quality-verification/spec.md`

## Summary

Định nghĩa cổng kiểm chứng chung cho các task AI4SE của NutriQuor: rà soát contract, rà soát Swift model/service, rà soát trạng thái UI, Xcode build, xác nhận của con người và ghi evidence.

## Technical Context

**Language/Version**: Swift  
**Primary Dependencies**: SwiftUI, URLSession, async/await, Xcode build tooling  
**Storage**: Không áp dụng, ngoại trừ quy tắc token/trạng thái app trong từng feature spec  
**Testing**: Xcode build, QA thủ công, rà soát contract decode  
**Target Platform**: iOS  
**Project Type**: Ứng dụng di động  
**Performance Goals**: Kiểm chứng phát hiện lỗi biên dịch/decode/UI regression trước khi chấp nhận.  
**Constraints**: Không chức năng nào được chấp nhận chỉ dựa trên đầu ra AI.  
**Scale/Scope**: Áp dụng cho toàn bộ specs chức năng của NutriQuor.

## Constitution Check

- Backend API là ranh giới duy nhất khi chạy: REQUIRED.
- UI hiển thị sự thật từ backend: REQUIRED.
- Nguyên tắc scan/auth/trạng thái cục bộ áp dụng khi liên quan: REQUIRED.
- Chức năng app phải kiểm thử được: PASS.

## AI4SE Execution Flow

```text
Spec/plan/tasks của chức năng
  -> Codex Skills được chọn
  -> Codex triển khai hoặc rà soát
  -> kiểm tra contract
  -> kiểm tra chất lượng UI
  -> Xcode build/QA thủ công
  -> con người xác nhận
  -> ghi evidence
```

## Verification Strategy

- Kiểm tra contract: so sánh Swift DTO/service với response public của ViFood-API.
- Kiểm tra UI: kiểm tra trạng thái đang xử lý, rỗng, thành công, lỗi và text tiếng Việt.
- Kiểm tra build: chạy lệnh Xcode từ `NutriQuor/AGENTS.md`.
- Kiểm tra ranh giới bảo mật: tìm URL service nội bộ hoặc direct database/storage calls.
- Kiểm tra evidence: đảm bảo bản ghi AI4SE có verification và xác nhận của con người.

## Project Structure

```text
NutriQuor/specs
NutriQuor/NutriQuor/API
NutriQuor/NutriQuor/Core/Network
NutriQuor/NutriQuor/Core/Services
NutriQuor/NutriQuor/Models
NutriQuor/NutriQuor/ViewModels
NutriQuor/NutriQuor/Features
```

**Structure Decision**: Kiểm chứng dùng đường dẫn app và Spec Kit artifacts hiện có. Không cần thêm module runtime mới.

## Complexity Tracking

Không có vi phạm constitution.
