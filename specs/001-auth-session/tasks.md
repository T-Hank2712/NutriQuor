# Tasks: Phiên Xác Thực

**Input**: Tài liệu thiết kế từ `/specs/001-auth-session/`

**Prerequisites**: `spec.md`, `plan.md`, root `AGENTS.md`, `NutriQuor/AGENTS.md`, `Sys-docs` liên quan.

## Phase 1: Chuẩn Bị Ngữ Cảnh AI4SE

- [ ] T001 Đọc root `AGENTS.md`, `NutriQuor/AGENTS.md` và `Sys-docs/02-architecture/component-responsibilities.md`.
- [ ] T002 Rà soát contract API xác thực trong docs/specs Backend trước khi chỉnh Swift DTO.
- [ ] T003 Chọn skills phù hợp: `vifood-ios-api-integration`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.

## Phase 2: Rà soát Nền Tảng

- [ ] T004 Rà soát `NutriQuor/NutriQuor/API/AuthAPI.swift`.
- [ ] T005 Rà soát `NutriQuor/NutriQuor/Core/Services/Auth/AuthService.swift`.
- [ ] T006 Rà soát `NutriQuor/NutriQuor/Core/Network/APIClient.swift` và hành vi gắn token.
- [ ] T007 Rà soát `NutriQuor/NutriQuor/Utilities/Extensions/TokenStorage.swift`.
- [ ] T008 Rà soát các file auth UI/ViewModel trong `Features/Login, Register` và `ViewModels`.

## Phase 3: User Story 1 - Đăng Ký Và Đăng Nhập (P1) MVP

**Goal**: Người dùng có thể đăng ký/đăng nhập qua ViFood-API và đi vào trạng thái đã xác thực.

**Independent Test**: Dùng dev backend hoặc response giả lập để xác nhận UI thành công/lỗi.

- [ ] T009 [US1] Kiểm tra đường dẫn request login/register chỉ trỏ đến ViFood-API.
- [ ] T010 [US1] Kiểm tra decode envelope thành công cho response xác thực.
- [ ] T011 [US1] Kiểm tra lưu token sau khi login thành công.
- [ ] T012 [US1] Kiểm tra map lỗi public cho thông tin đăng nhập không hợp lệ.
- [ ] T013 [US1] Xác nhận JSON/password/token thô không được hiển thị hoặc log.

## Phase 4: User Story 2 - Duy Trì Và Xóa Phiên (P2)

**Goal**: Phiên người dùng hiện có vẫn dùng được và có thể xóa an toàn.

**Independent Test**: Mô phỏng request được bảo vệ, refresh thất bại và logout.

- [ ] T014 [US2] Kiểm tra gắn bearer token cho request được bảo vệ.
- [ ] T015 [US2] Kiểm tra refresh hoặc fallback khi không được xác thực.
- [ ] T016 [US2] Kiểm tra logout xóa trạng thái cục bộ xác thực và đưa app về UI chưa xác thực.

## Phase 5: Kiểm Chứng Và Xác Nhận Của Con Người

- [ ] T017 Chạy Xcode build bằng `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS -derivedDataPath /private/tmp/nutriquor-derived CODE_SIGNING_ALLOWED=NO build`.
- [ ] T018 Xác nhận thủ công hành vi login, lỗi auth và logout với người phát triển.
- [ ] T019 Ghi evidence AI4SE: task id, ngữ cảnh, prompt, file thay đổi, kết quả kiểm chứng, xác nhận của con người và trạng thái cuối.
