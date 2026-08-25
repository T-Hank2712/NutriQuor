# Feature Specification: Lịch Sử, Tìm Kiếm Và Chi Tiết

**Feature Branch**: `003-history-search-detail`

**Created**: 2026-08-13

**Status**: Đã duyệt cho quy trình AI4SE

**Input**: Mô tả của người dùng: "NutriQuor hiển thị lịch sử quét của người dùng đã xác thực, chi tiết lịch sử, kết quả tìm kiếm và màn chi tiết tri thức từ các endpoint public của ViFood-API."

## AI4SE Context *(mandatory)*

- **Tài liệu ngữ cảnh**: `Sys-docs/02-architecture/communication-flow.md`, `Sys-docs/03-api-contracts`, `Sys-docs/04-data-models/user-history-model.md`, `Sys-docs/04-data-models/knowledge-graph-model.md`, `Sys-docs/06-ai4se`.
- **Quy tắc tác nhân**: root `AGENTS.md` và `NutriQuor/AGENTS.md`.
- **Artifact Spec Kit**: file `spec.md`, `plan.md`, `tasks.md` trong thư mục này.
- **Skills dự kiến**: `vifood-ios-api-integration`, `vifood-contract-sync-check`, `vifood-ios-ui-quality-check`, `vifood-verify-scan-history`, `vifood-ai4se-evidence-log`.
- **Vai trò Codex**: cập nhật API, DTO, ViewModel và UI cho history/search/detail chỉ thông qua contract Backend API.
- **Xác nhận của con người**: người phát triển xác nhận danh sách/chi tiết history, search, điều hướng detail, trạng thái rỗng và trạng thái lỗi.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Xem Lịch Sử Quét (Priority: P1)

Người dùng xem lại lịch sử quét từ Backend API.

**Why this priority**: History là luồng chính sau khi scan thành công.

**Independent Test**: Giả lập history response và xác nhận danh sách, trạng thái rỗng và trạng thái lỗi.

**Acceptance Scenarios**:

1. **Cho trước** người dùng có history, **Khi** mở màn history, **Thì** app hiển thị danh sách.
2. **Cho trước** người dùng chưa có history, **Khi** mở màn history, **Thì** app hiển thị trạng thái rỗng.
3. **Cho trước** người dùng chọn một history item, **Khi** app mở chi tiết, **Thì** app hiển thị result đã lưu và ảnh nếu Backend API trả `image_url`.

---

### User Story 2 - Tìm Kiếm Và Mở Chi Tiết (Priority: P2)

Người dùng tìm kiếm tri thức và mở detail từ item có id.

**Why this priority**: Cho phép tra cứu ngoài luồng scan.

**Independent Test**: Mock search result có item có id và không có id.

**Acceptance Scenarios**:

1. **Cho trước** keyword hợp lệ, **Khi** người dùng search, **Thì** app hiển thị kết quả.
2. **Cho trước** item có id, **Khi** người dùng chọn item, **Thì** app gọi detail API.
3. **Cho trước** item không có id, **Khi** người dùng chọn item, **Thì** app không gọi detail sai.
4. **Cho trước** detail response có public sections, **Khi** màn detail load thành công, **Thì** app hiển thị nội dung theo section mà không đưa provenance/debug nội bộ vào UI.

### Edge Cases

- Unauthorized phải đưa người dùng về auth/trạng thái lỗi phù hợp.
- Không hiển thị JSON thô.
- Search/detail chỉ dùng Backend API.
- History response rỗng hoặc thiếu ảnh vẫn hiển thị được list/detail text.
- Item không có `id` hoặc id rỗng không mở detail.
- Search không có kết quả phải hiển thị trạng thái rỗng thay vì lỗi.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: App PHẢI fetch history chỉ từ Backend API bằng request đã xác thực.
- **FR-002**: App PHẢI hiển thị danh sách history, trạng thái rỗng và trạng thái lỗi.
- **FR-003**: App PHẢI gọi endpoint search của Backend API để tìm kiếm.
- **FR-004**: App PHẢI mở detail chỉ khi result item có id hợp lệ.
- **FR-005**: App PHẢI hiển thị field public từ backend mà không expose JSON thô.
- **FR-006**: App PHẢI fetch history detail chỉ bằng public `analysis_id` thông qua Backend API.
- **FR-007**: App PHẢI xem `image_ref` là metadata tham chiếu/hiển thị và dùng `image_url` để load ảnh khi backend cung cấp.
- **FR-008**: App KHÔNG ĐƯỢC gọi MongoDB, Neo4j, S3, Builder hoặc AIaaS trực tiếp.
- **FR-009**: App PHẢI hiển thị unauthorized/network/not-found errors thành trạng thái UIs có kiểm soát.
- **FR-010**: App KHÔNG ĐƯỢC trình bày nội dung search/detail như tư vấn y tế hoặc kết luận an toàn tuyệt đối.

### Key Entities

- **HistoryItem**: Một item lịch sử quét từ Backend API.
- **HistoryDetail**: Một chi tiết phân tích đã lưu do Backend API trả về.
- **SearchResultItem**: Một kết quả tìm kiếm public.
- **DetailViewState**: Trạng thái UI cho đang xử lý, thành công và lỗi của detail.
- **KnowledgeSection**: Public section do Backend API trả về để hiển thị detail.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Màn history hiển thị danh sách, trạng thái rỗng và trạng thái lỗi.
- **SC-002**: Search results hiển thị mà không lộ raw payload.
- **SC-003**: Detail API chỉ được gọi cho item có id.
- **SC-004**: Mọi request đi qua Backend API client.
- **SC-005**: Xcode build pass sau thay đổi history/search/detail.
- **SC-006**: Manual rà soát xác nhận không có direct database/storage/internal-service call trong iOS code.
- **SC-007**: Bằng chứng AI4SE ghi nhận verification và xác nhận của con người.

## Assumptions

- Backend API scope history theo người dùng hiện tại.
- Contract search/detail đủ ổn định để mapping DTO.
- Backend API sở hữu MongoDB history access và Neo4j search/detail access.
- App có thể cache ảnh trong memory cho hiệu năng UI nhưng không xem cache là nguồn đúng duy nhất.
