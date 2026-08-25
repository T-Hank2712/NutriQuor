# Feature Specification: Phân Tích Ảnh Nhãn

**Feature Branch**: `002-scan-analysis`

**Created**: 2026-07-06

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "NutriQuor cho phép người dùng chụp hoặc chọn ảnh nhãn thực phẩm, xem trước ảnh và upload đến ViFood-API `/products/extract`; sau khi backend trả kết quả thành công, app chuyển dữ liệu cho feature hiển thị kết quả."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/02-architecture/communication-flow.md`, `Sys-docs/03-api-contracts`, `Sys-docs/04-data-models/analysis-result-schema.md`, `Sys-docs/06-ai4se`, `Sys-docs/08-testing`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.
- **Vai trò Codex**: chỉ cập nhật luồng chọn/chụp ảnh, preview, multipart upload, loading/error và bàn giao `Product` sau khi rà soát contract.
- **Xác nhận của con người**: người phát triển xác nhận hành vi xem trước ảnh, upload, đang xử lý, lỗi và chuyển sang màn kết quả khi thành công.

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

### User Story 2 - Upload Ảnh Và Bàn Giao Kết Quả (Priority: P1)

App gửi ảnh đến Backend API `/products/extract`, nhận kết quả phân tích public và bàn giao `Product` cho feature hiển thị kết quả.

**Why this priority**: Đây là trải nghiệm cốt lõi của sản phẩm.

**Independent Test**: Giả lập Backend API thành công và xác nhận app chuyển từ preview/loading sang màn result bằng `Product` đã decode.

**Acceptance Scenarios**:

1. **Cho trước** ảnh và token hợp lệ, **Khi** app upload ảnh, **Thì** app hiển thị trạng thái đang xử lý rồi nhận `Product` thành công.
2. **Cho trước** Backend trả lỗi, **Khi** upload thất bại, **Thì** app hiển thị trạng thái lỗi dễ hiểu.
3. **Cho trước** Backend trả envelope `{ message, data }`, **Khi** upload thành công, **Thì** app decode `data` thành `Product` và gọi callback chuyển màn.
4. **Cho trước** response thiếu field optional, **Khi** app decode result, **Thì** app vẫn bàn giao dữ liệu hợp lệ mà không tự tạo dữ liệu giả.

### Edge Cases

- App không gọi Builder/AIaaS/S3 trực tiếp.
- App không render chi tiết result trong feature này; phần render thuộc `006-analysis-result-display`.
- Multipart request thiếu ảnh hoặc ảnh không hợp lệ phải bị chặn trước hoặc hiển thị lỗi public.
- Backend trả lỗi Builder/AIaaS/storage/history phải được map thành thông báo dễ hiểu, không hiển thị URL nội bộ.
- `image_ref`/`image_url` nếu có chỉ được bàn giao theo `Product`; app không tự tạo storage key.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: App PHẢI cho phép chụp hoặc chọn ảnh nhãn.
- **FR-002**: App PHẢI hiển thị ảnh đã chọn trước khi upload.
- **FR-003**: App PHẢI upload ảnh chỉ đến ViFood-API `/products/extract`.
- **FR-004**: App PHẢI hiển thị trạng thái đang xử lý và lỗi trong màn preview/upload.
- **FR-005**: App PHẢI bàn giao `Product` đã decode cho feature hiển thị kết quả khi Backend API trả thành công.
- **FR-006**: App PHẢI decode response thành công qua envelope `{ message, data }`.
- **FR-007**: App PHẢI để feature `006-analysis-result-display` chịu trách nhiệm render product name, ingredients, additives, nutritions, warning, manufacturer, dates, net weight, origin và detail navigation.
- **FR-008**: App PHẢI không tự render raw JSON hoặc debug payload trong màn preview/upload.
- **FR-009**: App KHÔNG ĐƯỢC expose JSON thô, lỗi nội bộ, Builder URL, AIaaS URL, giả định S3 key hoặc debug metadata.
- **FR-010**: App PHẢI notify history/home refresh chỉ sau khi Backend API trả final analysis response thành công.

### Key Entities

- **SelectedImage**: Ảnh cục bộ được chọn để upload.
- **ScanUploadViewState**: Trạng thái UI cho preview, đang xử lý và lỗi.
- **ProductAnalysis**: Kết quả phân tích public cuối cùng do Backend API trả về và được bàn giao cho màn result.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Người dùng có thể xem trước ảnh trước khi upload.
- **SC-002**: Response backend thành công được decode thành `Product` và chuyển sang feature hiển thị kết quả.
- **SC-003**: Lỗi backend/network hiển thị UI lỗi có kiểm soát.
- **SC-004**: App không gọi URL service nội bộ.
- **SC-005**: Xcode build pass sau thay đổi scan/result.
- **SC-006**: Contract rà soát xác nhận upload request và envelope decode khớp response public hiện tại của Backend API.
- **SC-007**: Bằng chứng AI4SE ghi nhận file thay đổi, kiểm chứng và xác nhận của con người.

## Assumptions

- Backend API sở hữu phân tích và lưu trữ kết quả.
- Networking layer của app hỗ trợ multipart upload.
- Nội bộ Backend API, Builder và AIaaS được ẩn khỏi app theo thiết kế.
- Result UI được đặc tả riêng trong `006-analysis-result-display`.
