# Feature Specification: Hồ Sơ Và Gia Đình

**Feature Branch**: `004-profile-family`

**Created**: 2026-08-25

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "NutriQuor cho phép người dùng đã xác thực xem/cập nhật thông tin hồ sơ cơ bản và quản lý hồ sơ gia đình cơ bản thông qua ViFood-API."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/00-overview/system-context.md`, `Sys-docs/02-architecture/component-responsibilities.md`, `Sys-docs/03-api-contracts`, `Sys-docs/06-ai4se`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.
- **Vai trò Codex**: cập nhật SwiftUI, ViewModel, API và DTO cho profile/family chỉ sau khi rà soát contract.
- **Xác nhận của con người**: người phát triển xác nhận profile edit, family list/create/update/delete và chấp nhận cuối cùng.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Xem Và Cập Nhật Hồ Sơ Hiện Tại (Priority: P1)

Người dùng xem và cập nhật thông tin hồ sơ cơ bản của mình trong app.

**Why this priority**: Hồ sơ cơ bản là một phần của trạng thái người dùng sau đăng nhập và được dùng trong setting/profile UI.

**Independent Test**: Dùng dev backend hoặc response giả lập để cập nhật first name, last name hoặc avatar, sau đó xác nhận UI và `AppState` đồng bộ.

**Acceptance Scenarios**:

1. **Cho trước** người dùng đã đăng nhập, **Khi** mở màn profile, **Thì** app hiển thị thông tin hồ sơ public hiện có.
2. **Cho trước** payload hợp lệ, **Khi** người dùng lưu chỉnh sửa, **Thì** app gọi ViFood-API và cập nhật UI theo response.
3. **Cho trước** payload không hợp lệ hoặc backend trả lỗi, **Khi** người dùng lưu, **Thì** app hiển thị lỗi public dễ hiểu.

---

### User Story 2 - Quản Lý Hồ Sơ Gia Đình (Priority: P2)

Người dùng xem, thêm, cập nhật và xóa hồ sơ gia đình cơ bản mà mình sở hữu.

**Why this priority**: Family profile là phần mở rộng người dùng-facing đang tồn tại trong app nhưng phải giữ phạm vi cơ bản.

**Independent Test**: Dev backend hoặc giả lập trả danh sách family, create/update/delete response, xác nhận UI cập nhật đúng.

**Acceptance Scenarios**:

1. **Cho trước** người dùng có family members, **Khi** mở setting/profile, **Thì** app hiển thị danh sách family profiles.
2. **Cho trước** thông tin family hợp lệ, **Khi** người dùng tạo mới, **Thì** app thêm profile theo response backend.
3. **Cho trước** người dùng xóa family profile, **Khi** backend trả thành công, **Thì** app loại item khỏi UI.

### Edge Cases

- Người dùng không được sửa profile của người khác nếu backend trả unauthorized/forbidden.
- Payload tên rỗng hoặc sai validation phải được chặn hoặc hiển thị lỗi.
- App không hiển thị hoặc quản lý bệnh nền, mục tiêu sức khỏe hoặc kết luận cá nhân hóa.
- Nếu backend chưa trả avatar, app dùng placeholder an toàn.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: App PHẢI chỉ gọi endpoint profile/family của ViFood-API.
- **FR-002**: App PHẢI hiển thị và cập nhật các field hồ sơ cơ bản do Backend API trả về.
- **FR-003**: App PHẢI quản lý family profiles chỉ thông qua Backend API và request đã xác thực.
- **FR-004**: App PHẢI map lỗi validation/auth/network thành thông báo UI có kiểm soát.
- **FR-005**: App KHÔNG ĐƯỢC expose luồng bệnh nền, mục tiêu sức khỏe hoặc cá nhân hóa y tế.
- **FR-006**: App KHÔNG ĐƯỢC gọi Neo4j, MongoDB, S3, Builder hoặc AIaaS trực tiếp.
- **FR-007**: App PHẢI decode response qua public envelope contract.

### Key Entities

- **Profile**: Hồ sơ cơ bản gồm public id, first name, last name và avatar optional.
- **FamilyProfile**: Hồ sơ cơ bản thuộc quyền sở hữu hoặc quyền truy cập của người dùng đã xác thực.
- **ProfileEditState**: Trạng thái UI cho form chỉnh sửa, validation, đang lưu và hiển thị lỗi.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Người dùng có thể cập nhật field hồ sơ cơ bản và thấy response đã cập nhật.
- **SC-002**: Người dùng có thể list, add, update và delete family profiles khi backend cho phép.
- **SC-003**: UI profile/family không expose disease hoặc luồng health-goal.
- **SC-004**: Xcode build pass sau thay đổi profile/family.
- **SC-005**: Bằng chứng AI4SE ghi nhận ngữ cảnh, file thay đổi, kiểm chứng và xác nhận của con người.

## Assumptions

- Backend API là nguồn đúng duy nhất cho ownership và authorization của profile/family.
- Scope profile/family hiện tại được giới hạn ở thông tin cơ bản cho hệ thống khóa luận.
- App dùng SwiftUI/MVVM và shared API client hiện có.
