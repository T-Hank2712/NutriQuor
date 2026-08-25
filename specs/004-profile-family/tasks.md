# Tasks: Hồ Sơ Và Gia Đình

**Input**: Tài liệu thiết kế từ `/specs/004-profile-family/`

**Prerequisites**: `spec.md`, `plan.md`, root `AGENTS.md`, `NutriQuor/AGENTS.md`, profile/family API contract.

## Phase 1: Chuẩn Bị Ngữ Cảnh AI4SE

- [ ] T001 Đọc root `AGENTS.md`, `NutriQuor/AGENTS.md`, docs profile/family trong `Sys-docs/03-api-contracts` nếu có, và `Sys-docs/06-ai4se`.
- [ ] T002 Xác nhận scope profile/family hiện tại: chỉ field cơ bản, không có bệnh nền hoặc luồng health-goal.
- [ ] T003 Chọn skills phù hợp: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.

## Phase 2: Rà soát Nền Tảng

- [ ] T004 Rà soát `NutriQuor/NutriQuor/API/UserProfileAPI.swift`.
- [ ] T005 Rà soát `NutriQuor/NutriQuor/Core/Services/UserProfileAPIService.swift`.
- [ ] T006 Rà soát `NutriQuor/NutriQuor/ViewModels/UserProfileViewModel.swift` và `FamilyProfilesViewModel.swift`.
- [ ] T007 Rà soát `NutriQuor/NutriQuor/Models/Auth/Profile.swift`.
- [ ] T008 Rà soát `NutriQuor/NutriQuor/Features/Setting/ProfileView.swift` và `FamilyMemberProfile.swift`.

## Phase 3: User Story 1 - Xem Và Cập Nhật Hồ Sơ Hiện Tại (P1) MVP

**Goal**: Người dùng có thể xem và cập nhật thông tin hồ sơ cơ bản.

**Independent Test**: Dev backend hoặc giả lập update response và kiểm tra UI + trạng thái app.

- [ ] T009 [US1] Kiểm tra request update profile dùng Backend API và API client có auth.
- [ ] T010 [US1] Kiểm tra DTO profile chỉ decode field public.
- [ ] T011 [US1] Kiểm tra form validation cho các field cơ bản bắt buộc.
- [ ] T012 [US1] Kiểm tra response thành công cập nhật UI và `AppState`.
- [ ] T013 [US1] Kiểm tra validation/auth/network errors hiển thị controlled messages.

## Phase 4: User Story 2 - Quản Lý Hồ Sơ Gia Đình (P2)

**Goal**: Người dùng có thể list, create, update và delete family profiles cơ bản.

**Independent Test**: Dev backend hoặc giả lập list/create/update/delete responses và kiểm tra trạng thái UI.

- [ ] T014 [US2] Kiểm tra request family list chỉ dùng Backend API.
- [ ] T015 [US2] Kiểm tra form create family profile và response mapping.
- [ ] T016 [US2] Kiểm tra update family luồng profile tái sử dụng basic profile contract.
- [ ] T017 [US2] Kiểm tra luồng xóa family profile xử lý thành công và lỗi not-found/forbidden.
- [ ] T018 [US2] Kiểm tra UI disease/health-goal/allergy-preference không được đưa vào scope này.

## Phase 5: Kiểm Chứng Và Xác Nhận Của Con Người

- [ ] T019 Chạy Xcode build bằng `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS -derivedDataPath /private/tmp/nutriquor-derived CODE_SIGNING_ALLOWED=NO build`.
- [ ] T020 Xác nhận thủ công hành vi chỉnh hồ sơ, family list/create/update/delete và lỗi với người phát triển.
- [ ] T021 Ghi evidence AI4SE: task id, ngữ cảnh, file thay đổi, contract checks, build/kiểm chứng thủ công, xác nhận của con người và trạng thái cuối.
