# Feature Specification: Phân Tích Ảnh Nhãn

**Feature Branch**: `002-scan-analysis`

**Created**: 2026-08-13

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "NutriQuor cho phép người dùng chụp hoặc chọn ảnh nhãn thực phẩm, xem trước ảnh, upload đến ViFood-API `/products/extract` và hiển thị kết quả phân tích public cuối cùng."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/02-architecture/communication-flow.md`, `Sys-docs/03-api-contracts`, `Sys-docs/04-data-models/analysis-result-schema.md`, `Sys-docs/06-ai4se`, `Sys-docs/08-testing`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.
- **Vai trò Codex**: chỉ cập nhật luồng scan/result SwiftUI và DTO mapping sau khi rà soát contract.
- **Xác nhận của con người**: người phát triển xác nhận hành vi xem trước ảnh, upload, đang xử lý, kết quả và lỗi.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Chọn Hoặc Chụp Ảnh Nhãn (Priority: P1)

Người dùng chụp hoặc chọn ảnh nhãn thực phẩm và xem trước ảnh trước khi gửi.

**Why this priority**: Đây là đầu vào của luồng phân tích chính.

**Independent Test**: Chọn/chụp ảnh, xác nhận phần xem trước ảnh xuất hiện và nút gửi khả dụng.

**Acceptance Scenarios**:

1. **Cho trước** người dùng chọn ảnh hợp lệ, **Khi** ảnh được load, **Thì** app hiển thị phần xem trước ảnh.
2. **Cho trước** chưa có ảnh, **Khi** người dùng chưa chọn gì, **Thì** app không gửi request phân tích.
3. **Cho trước** người dùng hủy chọn ảnh, **Khi** quay lại màn scan, **Thì** app giữ trạng thái an toàn và không gọi API.

---

### User Story 2 - Upload Ảnh Và Hiển Thị Kết Quả (Priority: P1)

App gửi ảnh đến Backend API `/products/extract` và hiển thị kết quả phân tích.

**Why this priority**: Đây là trải nghiệm cốt lõi của sản phẩm.

**Independent Test**: Giả lập Backend API thành công và xác nhận UI hiển thị product, ingredients, additives, nutritions, warning.

**Acceptance Scenarios**:

1. **Cho trước** ảnh và token hợp lệ, **Khi** app upload ảnh, **Thì** app hiển thị trạng thái đang xử lý rồi kết quả thành công.
2. **Cho trước** Backend trả lỗi, **Khi** upload thất bại, **Thì** app hiển thị trạng thái lỗi dễ hiểu.
3. **Cho trước** response có item có `id`, **Khi** người dùng chọn item, **Thì** app cho phép mở detail qua Backend API.
4. **Cho trước** response thiếu field optional, **Khi** app decode result, **Thì** app vẫn hiển thị phần có dữ liệu mà không tự tạo dữ liệu giả.

### Edge Cases

- App không gọi Builder/AIaaS/S3 trực tiếp.
- App không tự sinh warning nếu backend không trả.
- Item có id mới cho phép mở detail.
- Multipart request thiếu ảnh hoặc ảnh không hợp lệ phải bị chặn trước hoặc hiển thị lỗi public.
- Backend trả lỗi Builder/AIaaS/storage/history phải được map thành thông báo dễ hiểu, không hiển thị URL nội bộ.
- `image_ref`/`image_url` được xem là dữ liệu public từ Backend API; app không tự tạo storage key.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: App PHẢI cho phép chụp hoặc chọn ảnh nhãn.
- **FR-002**: App PHẢI hiển thị ảnh đã chọn trước khi upload.
- **FR-003**: App PHẢI upload ảnh chỉ đến ViFood-API `/products/extract`.
- **FR-004**: App PHẢI hiển thị trạng thái đang xử lý, thành công và lỗi.
- **FR-005**: App PHẢI hiển thị các nhóm phân tích từ response Backend API mà không tự tạo dữ liệu thiếu.
- **FR-006**: App PHẢI decode response thành công qua envelope `{ message, data }`.
- **FR-007**: App PHẢI hỗ trợ các nhóm kết quả: product name, ingredients, additives, nutritions, warning, manufacturer, dates, net weight, origin và image metadata khi backend trả về.
- **FR-008**: App PHẢI mở detail chỉ với entity có `id` public hợp lệ.
- **FR-009**: App KHÔNG ĐƯỢC expose JSON thô, lỗi nội bộ, Builder URL, AIaaS URL, giả định S3 key hoặc debug metadata.
- **FR-010**: App PHẢI notify history/home refresh chỉ sau khi Backend API trả final analysis response thành công.

### Key Entities

- **SelectedImage**: Ảnh cục bộ được chọn để upload.
- **AnalysisResultViewState**: Trạng thái UI cho đang xử lý, thành công và lỗi.
- **AnalysisItem**: Item kết quả có thể có hoặc không có detail id.
- **ProductAnalysis**: Kết quả phân tích public cuối cùng do Backend API trả về.
- **LinkedEntity**: Ingredient/additive/nutrient item có thể chứa id để mở detail.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Người dùng có thể xem trước ảnh trước khi upload.
- **SC-002**: Response backend thành công hiển thị UI kết quả theo nhóm.
- **SC-003**: Lỗi backend/network hiển thị UI lỗi có kiểm soát.
- **SC-004**: App không gọi URL service nội bộ.
- **SC-005**: Xcode build pass sau thay đổi scan/result.
- **SC-006**: Contract rà soát xác nhận model app khớp response public hiện tại của Backend API.
- **SC-007**: Bằng chứng AI4SE ghi nhận file thay đổi, kiểm chứng và xác nhận của con người.

## Assumptions

- Backend API sở hữu phân tích và lưu trữ kết quả.
- Networking layer của app hỗ trợ multipart upload.
- Nội bộ Backend API, Builder và AIaaS được ẩn khỏi app theo thiết kế.
- Result UI mang tính hỗ trợ thông tin, không đưa ra tư vấn y tế hoặc kết luận an toàn thực phẩm tuyệt đối.
