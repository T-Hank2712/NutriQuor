# Feature Specification: Kiểm Chứng Contract Và Chất Lượng UI

**Feature Branch**: `005-contract-ui-quality-verification`

**Created**: 2026-08-25

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "Mọi thay đổi trong NutriQuor phải được kiểm chứng với contract Backend API, Swift decode models, trạng thái UIs, Xcode build và xác nhận của con người trước khi chấp nhận."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/03-api-contracts`, `Sys-docs/04-data-models`, `Sys-docs/06-ai4se/verification-process.md`, `Sys-docs/08-testing`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`, `vifood-pre-push-check` khi chuẩn bị chốt code.
- **Vai trò Codex**: thực hiện kiểm chứng contract/UI/build có phạm vi sau khi triển khai bất kỳ chức năng NutriQuor nào.
- **Xác nhận của con người**: người phát triển xác nhận hành vi cuối của app và duyệt chấp nhận.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Kiểm Chứng API Contract Và Decode Models (Priority: P1)

Người phát triển kiểm tra các DTO/service iOS có khớp response public của ViFood-API trước khi chấp nhận thay đổi.

**Why this priority**: App lỗi decode sẽ làm UI không hiển thị dữ liệu dù Backend API hoạt động đúng.

**Independent Test**: Đối chiếu API contract hoặc response mẫu với Swift `Decodable` models và service methods.

**Acceptance Scenarios**:

1. **Cho trước** contract Backend API đã chốt, **Khi** iOS model decode response, **Thì** các field bắt buộc/optional khớp contract.
2. **Cho trước** field optional bị thiếu, **Khi** app decode, **Thì** UI vẫn hiển thị phần có dữ liệu.
3. **Cho trước** backend đổi field public, **Khi** Codex sửa app, **Thì** spec/task liên quan được cập nhật trước hoặc cùng lúc.

---

### User Story 2 - Kiểm Chứng Chất Lượng UI Và States (Priority: P1)

Người phát triển kiểm tra màn hình iOS có trạng thái đang xử lý, rỗng, thành công, lỗi và text tiếng Việt phù hợp.

**Why this priority**: Đề tài là ứng dụng di động cho người dùng cuối, nên trạng thái UI phải rõ và không lộ dữ liệu nội bộ.

**Independent Test**: Chạy app hoặc rà soát SwiftUI previews/trạng thái giả lập cho từng màn bị ảnh hưởng.

**Acceptance Scenarios**:

1. **Cho trước** API đang xử lý, **Khi** màn hình chờ response, **Thì** UI hiển thị trạng thái đang xử lý.
2. **Cho trước** response rỗng, **Khi** màn hình không có dữ liệu, **Thì** UI hiển thị trạng thái rỗng.
3. **Cho trước** lỗi public, **Khi** request thất bại, **Thì** UI hiển thị thông báo dễ hiểu.

---

### User Story 3 - Kiểm Chứng Build Và Xác Nhận Của Con Người (Priority: P2)

Người phát triển chạy build và xác nhận kết quả cuối trước khi tích hợp/chốt task.

**Why this priority**: Output AI chỉ là bản nháp kỹ thuật cho đến khi build/test/rà soát và con người xác nhận.

**Independent Test**: Chạy Xcode build và ghi kết quả vào evidence.

**Acceptance Scenarios**:

1. **Cho trước** Codex đã sửa iOS code, **Khi** chạy Xcode build, **Thì** build pass hoặc lỗi được ghi và sửa.
2. **Cho trước** verification pass, **Khi** developer rà soát luồng, **Thì** developer xác nhận hoặc yêu cầu chỉnh tiếp.

### Edge Cases

- Nếu RTK không khả dụng, dùng lệnh gốc và ghi rõ trong evidence.
- Nếu Xcode build không thể chạy do môi trường, ghi blocker và dùng rà soát/contract/QA thủ công thay thế tạm thời.
- Nếu build pass nhưng UI sai contract, task vẫn chưa được chấp nhận.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Mỗi task triển khai NutriQuor PHẢI xác định API contracts và Swift models bị ảnh hưởng.
- **FR-002**: Mỗi chức năng thay đổi PHẢI kiểm tra trạng thái đang xử lý, thành công, rỗng và lỗi khi phù hợp.
- **FR-003**: Mỗi chức năng thay đổi PHẢI chạy Xcode build trừ khi bị chặn bởi môi trường.
- **FR-004**: Output của Codex PHẢI được rà soát theo root và NutriQuor AGENTS rules trước khi chấp nhận.
- **FR-005**: Xác nhận của con người PHẢI được ghi nhận trước khi đánh dấu task hoàn thành.
- **FR-006**: Bằng chứng AI4SE PHẢI ghi context, file thay đổi, verification, issues và trạng thái cuối.

### Key Entities

- **ContractCheck**: Mapping giữa response Backend API và hành vi Swift DTO/service.
- **UIStateCheck**: Rà soát các trạng thái hiển thị của màn hình người dùng-facing.
- **BuildEvidence**: Lệnh/kết quả Xcode build hoặc blocker đã ghi nhận.
- **HumanConfirmation**: Developer chấp nhận hoặc yêu cầu chỉnh sửa.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Mỗi task AI4SE hoàn tất của NutriQuor có kết quả kiểm chứng liên quan.
- **SC-002**: Contract mismatch được phát hiện trước final human chấp nhận.
- **SC-003**: Build command/result hoặc blocker được ghi nhận cho code changes.
- **SC-004**: Log bằng chứng có trạng thái xác nhận của con người.

## Assumptions

- Specs theo từng chức năng định nghĩa hành vi người dùng-facing.
- Spec này định nghĩa cổng kiểm chứng chung cho mọi chức năng NutriQuor.
- Lệnh Xcode hiện tại trong `NutriQuor/AGENTS.md` là cách kiểm chứng build ưu tiên.
