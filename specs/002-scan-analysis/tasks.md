# Tasks: Phân Tích Ảnh Nhãn

**Input**: Tài liệu thiết kế từ `/specs/002-scan-analysis/`

**Prerequisites**: `spec.md`, `plan.md`, root `AGENTS.md`, `NutriQuor/AGENTS.md`, docs scan/API/data-model.

## Phase 1: Chuẩn Bị Ngữ Cảnh AI4SE

- [ ] T001 Đọc root `AGENTS.md`, `NutriQuor/AGENTS.md`, `Sys-docs/02-architecture/communication-flow.md` và `Sys-docs/04-data-models/analysis-result-schema.md`.
- [ ] T002 Xác nhận contract public API `/products/extract` và envelope trước khi chỉnh Swift models.
- [ ] T003 Chọn skills phù hợp: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.

## Phase 2: Rà soát Nền Tảng

- [ ] T004 Rà soát `NutriQuor/NutriQuor/API/ProductAPI.swift`.
- [ ] T005 Rà soát `NutriQuor/NutriQuor/Core/Services/ProductService.swift`.
- [ ] T006 Rà soát `NutriQuor/NutriQuor/ViewModels/ScanNutriViewModel.swift`.
- [ ] T007 Rà soát `NutriQuor/NutriQuor/Models/Product.swift` và `NutriQuor/NutriQuor/Models/DTOs/AnalyzeResponse.swift`.
- [ ] T008 Rà soát các file scan UI trong `NutriQuor/NutriQuor/Features/ScanNutri`.

## Phase 3: User Story 1 - Chọn Hoặc Chụp Ảnh Nhãn (P1) MVP

**Goal**: Người dùng có thể chọn/chụp và xem trước ảnh nhãn trước khi upload.

**Independent Test**: Chọn/chụp ảnh, hủy picker và xác nhận không upload khi chưa có ảnh.

- [ ] T009 [US1] Kiểm tra tích hợp camera/photo picker và hành vi an toàn với quyền truy cập.
- [ ] T010 [US1] Kiểm tra trạng thái xem trước ảnh trước khi upload.
- [ ] T011 [US1] Kiểm tra upload action bị disable hoặc guard khi chưa chọn ảnh.

## Phase 4: User Story 2 - Upload Ảnh Và Hiển Thị Kết Quả (P1)

**Goal**: App upload ảnh đã chọn đến Backend API và hiển thị phân tích public cuối cùng.

**Independent Test**: Dùng dev backend hoặc giả lập thành công/lỗi response để kiểm tra UI đang xử lý/kết quả/lỗi.

- [ ] T012 [US2] Kiểm tra multipart upload chỉ đi đến ViFood-API `/products/extract`.
- [ ] T013 [US2] Kiểm tra decode envelope thành công và mapping `Product` cuối cùng.
- [ ] T014 [US2] Kiểm tra UI kết quả theo nhóm: product name, ingredients, additives, nutritions, warning, manufacturer, dates, net weight và origin.
- [ ] T015 [US2] Kiểm tra detail navigation chỉ xuất hiện với item có `id` hợp lệ.
- [ ] T016 [US2] Kiểm tra lỗi backend/network/internal-service được map thành thông báo tiếng Việt an toàn.
- [ ] T017 [US2] Kiểm tra notify refresh home/history chỉ xảy ra sau khi phân tích thành công.

## Phase 5: Kiểm Chứng Và Xác Nhận Của Con Người

- [ ] T018 Chạy Xcode build bằng `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS -derivedDataPath /private/tmp/nutriquor-derived CODE_SIGNING_ALLOWED=NO build`.
- [ ] T019 Xác nhận thủ công hành vi xem trước ảnh, upload, đang xử lý, kết quả, lỗi và detail-link với người phát triển.
- [ ] T020 Ghi evidence AI4SE: task id, ngữ cảnh, prompt summary, file thay đổi, contract check, build/kiểm chứng thủ công, xác nhận của con người và trạng thái cuối.
