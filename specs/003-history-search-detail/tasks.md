# Tasks: Lịch Sử, Tìm Kiếm Và Chi Tiết

**Input**: Tài liệu thiết kế từ `/specs/003-history-search-detail/`

**Prerequisites**: `spec.md`, `plan.md`, root `AGENTS.md`, `NutriQuor/AGENTS.md`, contracts history/search/detail.

## Phase 1: Chuẩn Bị Ngữ Cảnh AI4SE

- [ ] T001 Đọc root `AGENTS.md`, `NutriQuor/AGENTS.md`, docs history/search/detail trong `Sys-docs/03-api-contracts` và `Sys-docs/04-data-models`.
- [ ] T002 Xác nhận response envelope của Backend API cho scan history list/detail và search/detail.
- [ ] T003 Chọn skills phù hợp: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-verify-scan-history`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.

## Phase 2: Rà soát Nền Tảng

- [ ] T004 Rà soát `NutriQuor/NutriQuor/API/ScanHistoryAPI.swift` và `Core/Services/ScanHistoryService.swift`.
- [ ] T005 Rà soát `NutriQuor/NutriQuor/Models/ScanHistory.swift`.
- [ ] T006 Rà soát `NutriQuor/NutriQuor/ViewModels/HistoryViewModel.swift`.
- [ ] T007 Rà soát `NutriQuor/NutriQuor/API/SearchAPI.swift` và `Core/Services/SearchService.swift`.
- [ ] T008 Rà soát `NutriQuor/NutriQuor/Models/DTOs/SearchDTO.swift` và `SearchDetailDTO.swift`.

## Phase 3: User Story 1 - Xem Lịch Sử Quét (P1) MVP

**Goal**: Người dùng có thể xem scan history của người dùng hiện tại và mở chi tiết phân tích đã lưu.

**Independent Test**: Dùng dev backend hoặc giả lập response danh sách/chi tiết để kiểm tra danh sách, trạng thái rỗng, lỗi và trạng thái detail.

- [ ] T009 [US1] Kiểm tra request history list có auth và đi qua Backend API.
- [ ] T010 [US1] Kiểm tra DTO history decode `analysis_id`, product summary, timestamps, `image_ref` và `image_url`.
- [ ] T011 [US1] Kiểm tra danh sách, trạng thái rỗng và trạng thái lỗi trong `HistoryView`.
- [ ] T012 [US1] Kiểm tra history detail mở bằng `analysis_id` và hiển thị result đã lưu.
- [ ] T013 [US1] Kiểm tra việc tải ảnh thumbnail/detail chỉ dùng public `image_url`.

## Phase 4: User Story 2 - Tìm Kiếm Và Mở Chi Tiết (P2)

**Goal**: Người dùng có thể tìm kiếm tri thức public và mở detail chỉ khi có id.

**Independent Test**: Dùng result set có id hợp lệ, id rỗng và không có kết quả.

- [ ] T014 [US2] Kiểm tra search request và category load paths đi qua Backend API.
- [ ] T015 [US2] Kiểm tra search result DTO decode an toàn các field id/type/name/summary.
- [ ] T016 [US2] Kiểm tra item không có `id` hợp lệ không thể trigger detail request.
- [ ] T017 [US2] Kiểm tra detail screen hiển thị trạng thái đang xử lý, thành công, not-found và lỗi.
- [ ] T018 [US2] Kiểm tra detail UI bỏ qua provenance/debug/internal fields.

## Phase 5: Kiểm Chứng Và Xác Nhận Của Con Người

- [ ] T019 Chạy Xcode build bằng `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS -derivedDataPath /private/tmp/nutriquor-derived CODE_SIGNING_ALLOWED=NO build`.
- [ ] T020 Xác nhận thủ công hành vi danh sách/chi tiết history, search, detail, trạng thái rỗng và lỗi với người phát triển.
- [ ] T021 Ghi evidence AI4SE: task id, ngữ cảnh, file thay đổi, contract checks, build/kiểm chứng thủ công, xác nhận của con người và trạng thái cuối.
