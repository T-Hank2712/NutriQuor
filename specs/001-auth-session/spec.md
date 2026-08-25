# Feature Specification: Phiên Xác Thực

**Feature Branch**: `001-auth-session`

**Created**: 2026-08-13

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "NutriQuor quản lý đăng ký, đăng nhập, phiên người dùng hiện tại, làm mới token và đăng xuất thông qua ViFood-API."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/00-overview`, `Sys-docs/02-architecture/component-responsibilities.md`, `Sys-docs/03-api-contracts`, `Sys-docs/06-ai4se`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.
- **Vai trò Codex**: đọc code SwiftUI/MVVM hiện có, chỉ cập nhật model/service/view liên quan đến xác thực trong phạm vi đã đặc tả, chạy lệnh kiểm chứng khi có thay đổi triển khai.
- **Xác nhận của con người**: người phát triển xác nhận hành vi đăng nhập/đăng xuất thành công và chấp nhận kết quả cuối.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Đăng Ký Và Đăng Nhập (Priority: P1)

Người dùng đăng ký hoặc đăng nhập trong app để sử dụng các chức năng cá nhân hóa.

**Why this priority**: Xác thực là điều kiện cho scan, history và profile.

**Independent Test**: Dùng Backend API giả lập hoặc môi trường dev để đăng ký/đăng nhập và xác nhận app lưu token.

**Acceptance Scenarios**:

1. **Cho trước** thông tin đăng nhập hợp lệ, **Khi** người dùng đăng nhập, **Thì** app lưu token và chuyển sang trạng thái đã xác thực.
2. **Cho trước** thông tin đăng nhập sai, **Khi** người dùng đăng nhập, **Thì** app hiển thị lỗi public từ Backend API.
3. **Cho trước** người dùng đăng ký thành công, **Khi** app nhận response từ Backend API, **Thì** app chuyển trạng thái phù hợp mà không hiển thị JSON thô.

---

### User Story 2 - Duy Trì Và Xóa Phiên (Priority: P2)

App làm mới phiên đăng nhập khi phù hợp và xóa trạng thái nhạy cảm khi logout.

**Why this priority**: Giúp trải nghiệm ổn định và bảo vệ token.

**Independent Test**: Mô phỏng token hết hạn, refresh thành công/thất bại và logout.

**Acceptance Scenarios**:

1. **Cho trước** refresh token hợp lệ, **Khi** access token hết hạn, **Thì** app refresh và retry request phù hợp.
2. **Cho trước** người dùng logout, **Khi** logout hoàn tất, **Thì** token/trạng thái cục bộ xác thực bị xóa.
3. **Cho trước** refresh token không hợp lệ, **Khi** request được retry, **Thì** app đưa người dùng về trạng thái cần đăng nhập lại.

### Edge Cases

- Backend trả unauthorized thì app không crash.
- Token không được log ra console.
- Secret không được hard-code trong app.
- App mất mạng khi login thì hiển thị thông báo dễ hiểu.
- Response backend đổi envelope thì DTO/service phải được đối chiếu contract trước khi sửa UI.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: App PHẢI chỉ gọi các endpoint xác thực của ViFood-API.
- **FR-002**: App PHẢI lưu auth token bằng pattern secure storage hiện có.
- **FR-003**: App PHẢI gắn bearer token vào các request Backend API được bảo vệ.
- **FR-004**: App PHẢI map lỗi xác thực từ backend thành trạng thái UI dễ hiểu.
- **FR-005**: App PHẢI xóa token và trạng thái xác thực khi logout.
- **FR-006**: App KHÔNG ĐƯỢC gọi Builder, AIaaS, S3, MongoDB hoặc Neo4j từ bất kỳ luồng xác thực nào.
- **FR-007**: App KHÔNG ĐƯỢC log access token, refresh token hoặc password.
- **FR-008**: App PHẢI decode response thành công của Backend API theo public envelope contract.

### Key Entities

- **AuthSession**: Trạng thái đăng nhập cục bộ hiện tại.
- **AuthToken**: Access token và refresh token do Backend API trả về.
- **UserAccount**: Danh tính public của người dùng được hiển thị hoặc dùng trong app.
- **ProfileSummary**: Dữ liệu hồ sơ cơ bản đi kèm thông tin người dùng hiện tại khi backend trả về.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Đăng nhập hợp lệ chuyển app sang trạng thái đã xác thực.
- **SC-002**: Request được bảo vệ có bearer token.
- **SC-003**: Logout xóa trạng thái xác thực cục bộ.
- **SC-004**: Lỗi xác thực được hiển thị mà không lộ JSON thô.
- **SC-005**: Xcode build pass sau các thay đổi liên quan đến xác thực.
- **SC-006**: Bằng chứng AI4SE ghi nhận ngữ cảnh, file thay đổi, kiểm chứng và xác nhận của con người.

## Assumptions

- Contract xác thực của Backend API là nguồn đúng duy nhất.
- App đã có networking layer và storage layer để tái sử dụng.
- Project hiện dùng SwiftUI, async/await và shared API client.
