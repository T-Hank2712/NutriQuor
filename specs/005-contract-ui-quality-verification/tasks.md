# Tasks: Kiểm Chứng Contract Và Chất Lượng UI

**Input**: Tài liệu thiết kế từ `/specs/005-contract-ui-quality-verification/`

**Prerequisites**: Một spec riêng của chức năng `spec.md`, `plan.md`, `tasks.md`, root `AGENTS.md`, `NutriQuor/AGENTS.md`.

## Phase 1: Chuẩn Bị Ngữ Cảnh AI4SE

- [ ] T001 Xác định thư mục Spec Kit của chức năng đang được kiểm chứng.
- [ ] T002 Đọc root `AGENTS.md`, `NutriQuor/AGENTS.md` và các file API/data-model liên quan trong `Sys-docs`.
- [ ] T003 Chọn skills phù hợp: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.

## Phase 2: Kiểm Chứng Contract (P1)

- [ ] T004 [US1] Liệt kê toàn bộ Backend API endpoints bị ảnh hưởng.
- [ ] T005 [US1] Liệt kê toàn bộ file Swift API/service/model bị ảnh hưởng.
- [ ] T006 [US1] So sánh envelope thành công, tên field, cách xử lý optional/null và map lỗi.
- [ ] T007 [US1] Ghi nhận mọi mismatch và fix bắt buộc trước chấp nhận.

## Phase 3: Kiểm Chứng UI State (P1)

- [ ] T008 [US2] Kiểm tra trạng thái đang xử lý cho từng async screen bị ảnh hưởng.
- [ ] T009 [US2] Kiểm tra trạng thái thành công và grouped data rendering.
- [ ] T010 [US2] Kiểm tra trạng thái rỗng khi backend không trả dữ liệu.
- [ ] T011 [US2] Kiểm tra trạng thái lỗi/unauthorized/network và thông báo tiếng Việt.
- [ ] T012 [US2] Xác nhận UI không hiển thị JSON thô, internal URLs, debug metadata hoặc kết luận y tế không thuộc scope.

## Phase 4: Build Và Xác Nhận Của Con Người (P2)

- [ ] T013 [US3] Chạy Xcode build bằng `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS -derivedDataPath /private/tmp/nutriquor-derived CODE_SIGNING_ALLOWED=NO build`.
- [ ] T014 [US3] Nếu build fail, ghi tóm tắt lỗi và sửa hoặc đánh dấu bị chặn kèm lý do.
- [ ] T015 [US3] Trình bày verification summary để con người xác nhận.
- [ ] T016 [US3] Ghi nhận xác nhận của con người hoặc yêu cầu chỉnh sửa.

## Phase 5: Ghi Bằng chứng

- [ ] T017 Ghi evidence AI4SE với task id, feature spec, context docs, skills used, file thay đổi, commands, results, issues found, fixes, xác nhận của con người và trạng thái cuối.
