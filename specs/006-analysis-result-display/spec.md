# Feature Specification: Hiển Thị Kết Quả Phân Tích

**Feature Branch**: `006-analysis-result-display`

**Created**: 2026-07-12

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "NutriQuor hiển thị kết quả phân tích nhãn thực phẩm trên ứng dụng sau khi Backend API trả `Product` public result thành công."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/03-api-contracts`, `Sys-docs/04-data-models/analysis-result-schema.md`, `Sys-docs/02-architecture/communication-flow.md`, `Sys-docs/06-ai4se`, `Sys-docs/08-testing`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-ai4se-evidence-log`.
- **Vai trò Codex**: cập nhật Swift model/result UI/navigation sau khi rà soát contract public của Backend API.
- **Xác nhận của con người**: người phát triển xác nhận result UI hiển thị đúng các nhóm dữ liệu, optional field, detail link và thông báo an toàn.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Xem Tóm Tắt Kết Quả Phân Tích (Priority: P1)

Người dùng xem màn kết quả sau khi scan thành công, gồm tên sản phẩm, ảnh/metadata nếu có, tag tóm tắt và các nhóm dữ liệu chính.

**Why this priority**: Đây là màn hình người dùng dùng để hiểu kết quả phân tích.

**Independent Test**: Truyền một `Product` hợp lệ vào `AnalystView` và xác nhận màn hình render tên sản phẩm, thumbnail/tag nếu có và không crash khi thiếu optional field.

**Acceptance Scenarios**:

1. **Cho trước** `Product` có `product_name`, `net_weight`, `origin`, **Khi** mở màn result, **Thì** app hiển thị tên và tag tương ứng.
2. **Cho trước** `Product` thiếu `product_name`, **Khi** mở màn result, **Thì** app hiển thị tiêu đề fallback "Kết quả phân tích".
3. **Cho trước** `image_ref` hoặc `image_url`, **Khi** mở màn result, **Thì** app hiển thị thumbnail theo dữ liệu public từ Backend API.

---

### User Story 2 - Xem Dinh Dưỡng, Cảnh Báo Và Thông Tin Sản Phẩm (Priority: P1)

Người dùng xem các nhóm kết quả gồm dinh dưỡng, cảnh báo và thông tin sản phẩm.

**Why this priority**: Đây là dữ liệu cốt lõi của kết quả phân tích nhãn thực phẩm.

**Independent Test**: Truyền `Product` có `nutrient_items`, `warning`, `manufacturer`, `mfg_date`, `expiry_date`, `net_weight`, `origin` và xác nhận từng section xuất hiện đúng.

**Acceptance Scenarios**:

1. **Cho trước** `nutrient_items` có dữ liệu, **Khi** mở màn result, **Thì** app hiển thị section "Dinh dưỡng".
2. **Cho trước** `warning` rỗng hoặc không có, **Khi** mở màn result, **Thì** app không tự tạo section cảnh báo.
3. **Cho trước** các field thông tin sản phẩm thiếu một phần, **Khi** mở màn result, **Thì** app chỉ hiển thị các row có dữ liệu.

---

### User Story 3 - Xem Thành Phần, Phụ Gia Và Mở Detail Khi Có ID (Priority: P1)

Người dùng xem danh sách thành phần/phụ gia và mở chi tiết tri thức khi item có `id` public hợp lệ.

**Why this priority**: Đây là điểm nối giữa kết quả phân tích và dữ liệu tri thức của hệ thống.

**Independent Test**: Truyền `ingredient_items`, `additive_items`, `nutrient_items` có item có/không có `id` và xác nhận app chỉ mở detail khi có `id`.

**Acceptance Scenarios**:

1. **Cho trước** ingredients/additives có dữ liệu, **Khi** mở màn result, **Thì** app hiển thị section "Thành phần".
2. **Cho trước** item có `id`, **Khi** người dùng chọn item, **Thì** app mở `SearchDetailView` bằng id đó.
3. **Cho trước** item không có `id`, **Khi** người dùng xem danh sách, **Thì** app chỉ hiển thị text và không gọi detail sai.

### Edge Cases

- Response thiếu optional field không làm UI crash.
- App không tự sinh warning, đánh giá sức khỏe hoặc kết luận an toàn thực phẩm nếu Backend API không trả.
- App không hiển thị JSON thô, stack trace, Builder URL, AIaaS URL, S3 key nội bộ hoặc debug metadata.
- `image_ref`/`image_url` chỉ được dùng như dữ liệu public do Backend API trả về.
- Dữ liệu result hiển thị theo `Product` đã decode, không gọi trực tiếp Builder, AIaaS, S3, MongoDB hoặc Neo4j.
- Detail navigation chỉ chạy với id public hợp lệ.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: App PHẢI nhận `Product` public result đã decode từ flow scan/history.
- **FR-002**: App PHẢI hiển thị tên sản phẩm hoặc fallback "Kết quả phân tích".
- **FR-003**: App PHẢI hiển thị image thumbnail/metadata khi `image_ref` hoặc `image_url` có dữ liệu public.
- **FR-004**: App PHẢI hiển thị dinh dưỡng từ `nutrient_items` hoặc fallback `nutrition`.
- **FR-005**: App PHẢI hiển thị cảnh báo chỉ khi `warning` có dữ liệu.
- **FR-006**: App PHẢI hiển thị thành phần và phụ gia từ `ingredient_items`/`additive_items` hoặc fallback list text.
- **FR-007**: App PHẢI hiển thị thông tin sản phẩm gồm manufacturer, mfg_date, expiry_date, net_weight và origin khi có dữ liệu.
- **FR-008**: App PHẢI mở `SearchDetailView` chỉ khi item có `id` public hợp lệ.
- **FR-009**: App PHẢI bỏ qua optional field thiếu mà không tự tạo dữ liệu giả.
- **FR-010**: App KHÔNG ĐƯỢC expose raw JSON, stack trace, internal URL, debug metadata hoặc storage key nội bộ trong result UI.

### Key Entities

- **Product**: Kết quả phân tích public cuối cùng từ Backend API.
- **ProductIngredient**: Thành phần có thể có `id` để mở detail.
- **ProductAdditive**: Phụ gia có thể có `id`, `name`, `ins` để hiển thị.
- **ProductNutrient**: Dinh dưỡng có thể có `id`, `name`, `value`, `unit`.
- **AnalysisResultViewState**: Trạng thái UI result gồm dữ liệu có/không có section và detail navigation.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `AnalystView` render được `Product` thành các section result mà không crash khi thiếu optional field.
- **SC-002**: Dinh dưỡng, cảnh báo, thành phần/phụ gia và thông tin sản phẩm hiển thị đúng theo dữ liệu Backend API.
- **SC-003**: Item có `id` mở được detail; item không có `id` không gọi detail sai.
- **SC-004**: Result UI không hiển thị raw JSON, internal URL, stack trace hoặc debug payload.
- **SC-005**: Xcode build pass sau thay đổi result UI/model.
- **SC-006**: Contract rà soát xác nhận `Product` model khớp response public hiện tại của Backend API.
- **SC-007**: Bằng chứng AI4SE ghi nhận file thay đổi, kiểm chứng và xác nhận của con người.

## Assumptions

- `Product` được tạo từ Backend API public envelope `{ message, data }` trong feature scan hoặc history.
- Result UI chỉ hỗ trợ thông tin, không đưa ra tư vấn y tế hoặc kết luận an toàn thực phẩm tuyệt đối.
- Backend API và Builder chịu trách nhiệm chuẩn hóa/liên kết dữ liệu trước khi app hiển thị.
