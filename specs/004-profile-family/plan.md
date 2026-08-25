# Implementation Plan: Hồ Sơ Và Gia Đình

**Branch**: `004-profile-family` | **Date**: 2026-06-23 | **Spec**: `spec.md`

**Input**: Đặc tả chức năng từ `/specs/004-profile-family/spec.md`

## Summary

Triển khai và kiểm chứng màn hồ sơ người dùng cơ bản và hồ sơ gia đình thông qua ViFood-API. Chức năng này không được đưa lại scope bệnh nền, mục tiêu sức khỏe hoặc cá nhân hóa y tế.

## Technical Context

**Language/Version**: Swift  
**Primary Dependencies**: SwiftUI, URLSession, async/await  
**Storage**: Dữ liệu profile do Backend cung cấp; trạng thái app chỉ dùng để hiển thị trong phiên hiện tại  
**Testing**: Xcode build, API giả lập hoặc kiểm tra thủ công luồng profile, rà soát contract decode  
**Target Platform**: iOS  
**Project Type**: Ứng dụng di động  
**Performance Goals**: Form profile vẫn phản hồi tốt trong lúc async save/delete.  
**Constraints**: Chỉ gọi Backend API; scope profile/family cơ bản; không có disease/luồng health-goal.  
**Scale/Scope**: Hồ sơ người dùng hiện tại và family profiles thuộc quyền sở hữu/quyền truy cập.

## Constitution Check

- Backend API là ranh giới duy nhất khi chạy: PASS.
- UI hiển thị sự thật từ backend: PASS.
- Auth/trạng thái cục bộ vẫn được bảo vệ: REQUIRED.
- Chức năng app kiểm thử được bằng build hoặc luồng thủ công: REQUIRED.

## AI4SE Execution Flow

```text
Ngữ cảnh Sys-docs về profile/API
  -> root + NutriQuor AGENTS.md
  -> spec/plan/tasks của Spec Kit này
  -> iOS API integration + contract sync skills
  -> Codex triển khai
  -> Xcode build + thủ công profile/family verification
  -> con người xác nhận
  -> ghi evidence AI4SE
```

## Verification Strategy

- Chạy Xcode build sau khi có thay đổi code.
- Rà soát `UserProfileAPI`, `UserProfileAPIService`, `UserProfileViewModel`, `FamilyProfilesViewModel`.
- Rà soát `ProfileView`, `FamilyMemberProfile`, `FamilyProfilesCard`, các popup component liên quan profile.
- Xác nhận không có UI bệnh nền, mục tiêu sức khỏe hoặc cá nhân hóa y tế.
- Xác nhận mọi request đi qua shared Backend API client.

## Project Structure

```text
NutriQuor/API
NutriQuor/Core/Services
NutriQuor/Features/Setting
NutriQuor/Core/UI/Components
NutriQuor/Models/Auth
NutriQuor/ViewModels
```

**Structure Decision**: Dùng các đường dẫn setting/profile hiện có và shared API client. Không thêm graph/database/storage client trực tiếp.

## Complexity Tracking

Không có vi phạm constitution.
