# Implementation Plan: Phiên Xác Thực

**Branch**: `001-auth-session` | **Date**: 2026-08-13 | **Spec**: `spec.md`

**Input**: Đặc tả chức năng từ `/specs/001-auth-session/spec.md`

## Summary

Triển khai và kiểm chứng UI/trạng thái/networking xác thực với ViFood-API mà không truy cập trực tiếp service nội bộ. Quá trình AI4SE phải bắt đầu từ tài liệu ngữ cảnh và `AGENTS.md`, sau đó dùng `spec.md`, `plan.md`, `tasks.md` của Spec Kit trước khi Codex chỉnh code Swift.

## Technical Context

**Language/Version**: Swift  
**Primary Dependencies**: SwiftUI, URLSession, async/await  
**Storage**: Secure token/local storage hiện có  
**Testing**: Xcode build, API giả lập hoặc kiểm tra thủ công luồng auth  
**Target Platform**: iOS  
**Project Type**: Ứng dụng di động  
**Performance Goals**: Màn hình xác thực vẫn phản hồi tốt trong lúc gọi mạng.  
**Constraints**: App chỉ gọi ViFood-API; không log secret; không gọi trực tiếp service nội bộ.  
**Scale/Scope**: Login, register, người dùng hiện tại và logout cho một phiên người dùng mobile.

## Constitution Check

- Backend API là ranh giới duy nhất khi chạy: PASS.
- UI hiển thị sự thật từ backend và map lỗi thành thông báo public: PASS.
- Auth và trạng thái cục bộ được bảo vệ: REQUIRED.
- Chức năng app phải kiểm thử được bằng build hoặc luồng thủ công: REQUIRED.

## AI4SE Execution Flow

```text
Sys-docs + NutriQuor/AGENTS.md
  -> spec.md này
  -> plan.md này
  -> tasks.md
  -> Codex Skills được chọn
  -> Codex triển khai
  -> Xcode build/kiểm chứng auth thủ công
  -> con người xác nhận
  -> ghi evidence AI4SE
```

## Verification Strategy

- Chạy Xcode build sau khi có thay đổi code.
- Kiểm tra thủ công đăng nhập thành công, đăng nhập thất bại, gắn token và logout.
- Rà soát `AuthAPI`, `AuthService`, `APIClient`, `TokenStorage`, `LoginViewModel`, `RegisterViewModel`, `AppState`.
- Xác nhận token/password không xuất hiện trong log hoặc UI.

## Project Structure

```text
NutriQuor/API
NutriQuor/Core/Network
NutriQuor/Core/Services
NutriQuor/Features
NutriQuor/Models
NutriQuor/Storages
```

**Structure Decision**: Dùng các thư mục SwiftUI/MVVM hiện có. Không thêm networking stack thứ hai.

## Complexity Tracking

Không có vi phạm constitution.
