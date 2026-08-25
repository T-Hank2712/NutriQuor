# Tasks: Hiển Thị Kết Quả Phân Tích

**Input**: Tài liệu thiết kế từ `/specs/006-analysis-result-display/`

**Prerequisites**: `spec.md`, `plan.md`, root `AGENTS.md`, `NutriQuor/AGENTS.md`, docs API/data-model/result UI.

## Phase 1: Chuẩn Bị Ngữ Cảnh AI4SE

- [ ] T001 Đọc root `AGENTS.md`, `NutriQuor/AGENTS.md`, `Sys-docs/03-api-contracts` và `Sys-docs/04-data-models/analysis-result-schema.md`.
- [ ] T002 Xác nhận result display nhận `Product` public, không nhận AIaaS/raw Builder response.
- [ ] T003 Chọn skills phù hợp: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.

## Phase 2: Rà Soát Nền Tảng

- [ ] T004 Rà soát `NutriQuor/NutriQuor/Models/APIResponse.swift`.
- [ ] T005 Rà soát `NutriQuor/NutriQuor/Models/Product.swift`.
- [ ] T006 Rà soát `NutriQuor/NutriQuor/Features/ScanNutri/AnalystView.swift`.
- [ ] T007 Rà soát `NutriQuor/NutriQuor/Features/ScanNutri/ContainListView.swift`.
- [ ] T008 Rà soát `NutriQuor/NutriQuor/Core/UI/Components/Buttons/CameraButton.swift` và các nơi mở `AnalystView(product:)`.

## Phase 3: User Story 1 - Xem Tóm Tắt Kết Quả Phân Tích (P1)

**Goal**: Người dùng thấy màn kết quả với tên sản phẩm, thumbnail và tag tóm tắt khi dữ liệu có sẵn.

**Independent Test**: Truyền sample `Product` vào `AnalystView` và xác nhận hero section render đúng.

- [ ] T009 [US1] Kiểm tra `Product.productName`, `imageRef`, `imageUrl`, `netWeight`, `origin`, `ageRange` được render đúng.
- [ ] T010 [US1] Kiểm tra fallback "Kết quả phân tích" khi thiếu `product_name`.
- [ ] T011 [US1] Kiểm tra optional field rỗng không tạo tag trống hoặc layout lỗi.

## Phase 4: User Story 2 - Xem Dinh Dưỡng, Cảnh Báo Và Thông Tin Sản Phẩm (P1)

**Goal**: Người dùng xem đúng các section dữ liệu phân tích chính.

**Independent Test**: Dùng sample `Product` có/không có từng nhóm field để kiểm tra section xuất hiện hoặc ẩn đúng.

- [ ] T012 [US2] Kiểm tra section "Dinh dưỡng" dùng `nutrientItems` trước và fallback `nutrition`.
- [ ] T013 [US2] Kiểm tra section "Cảnh báo" chỉ xuất hiện khi `warning` có dữ liệu.
- [ ] T014 [US2] Kiểm tra section "Thông tin sản phẩm" chỉ hiển thị row có dữ liệu.
- [ ] T015 [US2] Kiểm tra result UI không tự sinh warning, đánh giá sức khỏe hoặc dữ liệu giả.

## Phase 5: User Story 3 - Xem Thành Phần, Phụ Gia Và Mở Detail Khi Có ID (P1)

**Goal**: Người dùng xem danh sách thành phần/phụ gia và mở detail chỉ khi item có id public.

**Independent Test**: Dùng sample `Product` có item có/không có `id` để kiểm tra navigation.

- [ ] T016 [US3] Kiểm tra `ContainListView` ưu tiên `ingredientItems`/`additiveItems` và fallback list text.
- [ ] T017 [US3] Kiểm tra ingredient/additive/nutrient có `id` mở `SearchDetailView`.
- [ ] T018 [US3] Kiểm tra item không có `id` chỉ hiển thị text, không gọi detail sai.
- [ ] T019 [US3] Kiểm tra result UI không expose raw JSON, stack trace, internal URL hoặc debug metadata.

## Phase 6: Kiểm Chứng Và Xác Nhận Của Con Người

- [ ] T020 Chạy Xcode build bằng `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS -derivedDataPath /private/tmp/nutriquor-derived CODE_SIGNING_ALLOWED=NO build`.
- [ ] T021 Xác nhận thủ công màn result từ scan/history: hero, dinh dưỡng, cảnh báo, thành phần/phụ gia, thông tin sản phẩm và detail-link.
- [ ] T022 Ghi evidence AI4SE: task id, ngữ cảnh, prompt summary, file thay đổi, contract check, build/kiểm chứng thủ công, xác nhận của con người và trạng thái cuối.
