<!--
Sync Impact Report
Version change: template -> 1.1.0
Modified principles: Development workflow requires the full AI4SE flow
Added sections: App boundaries, development workflow, verification and AI4SE evidence
Removed sections: placeholder sections
Templates requiring updates: none
Follow-up tasks: none
-->

# NutriQuor Constitution

NutriQuor là app iOS của hệ thống ViFood/NutriQuor. App cung cấp đăng ký, đăng nhập,
scan/chọn ảnh nhãn thực phẩm, xem kết quả phân tích, lịch sử quét và tra cứu tri thức.

## Core Principles

### I. Backend API Là Ranh Giới Runtime Duy Nhất

NutriQuor PHẢI chỉ gọi ViFood-API. App KHÔNG ĐƯỢC gọi trực tiếp Builder, AIaaS, S3,
MongoDB hoặc Neo4j. App không chứa secret backend, storage, graph hoặc model provider.

### II. UI Hiển Thị Sự Thật Từ Backend

App PHẢI hiển thị dữ liệu do Backend API trả về và KHÔNG ĐƯỢC tự suy diễn kết luận y tế,
an toàn thực phẩm hoặc graph linking. Nếu response thiếu id/detail, app hiển thị text
an toàn thay vì gọi sai endpoint.

### III. Luồng Scan Phải Truy Vết Được Và Thân Thiện Với Người Dùng

Luồng scan PHẢI có xem trước ảnh, trạng thái đang xử lý, thành công, rỗng và lỗi. Upload ảnh phân
tích PHẢI đi qua endpoint Backend API `/products/extract` bằng contract app đã thống nhất.

### IV. Auth Và Local State Phải Được Bảo Vệ

Token/session PHẢI được lưu theo pattern bảo mật hiện có. Request cần auth PHẢI gắn
`Authorization: Bearer <token>`. Logout PHẢI xóa trạng thái nhạy cảm khỏi app.

### V. Chức Năng App Phải Kiểm Thử Được

Mỗi chức năng UI/network PHẢI có cách kiểm chứng độc lập qua build Xcode, giả lập API hoặc
luồng thủ công. Thay đổi API contract PHẢI cập nhật model/service liên quan.

## App Boundaries

- `NutriQuor/API` và `Core/Network` là nơi gọi Backend API.
- `Features` chứa màn hình theo domain.
- `ViewModels` giữ trạng thái UI và gọi service.
- `Models` chứa DTO/domain model.
- `Storages` giữ token hoặc trạng thái cục bộ.

## Development Workflow

- Chức năng mới bắt đầu từ `specs/NNN-feature-name`.
- `spec.md` mô tả câu chuyện người dùng và kịch bản chấp nhận.
- `plan.md` mô tả màn hình, ViewModel, service và DTO bị ảnh hưởng.
- `tasks.md` chia việc theo từng câu chuyện người dùng có thể kiểm chứng độc lập.
- Mọi chức năng phải đi qua luồng AI4SE chuẩn:

```text
Tài liệu ngữ cảnh
  -> AGENTS.md
  -> Spec Kit spec/plan/tasks
  -> Codex Skills
  -> Codex triển khai/rà soát
  -> Kiểm chứng
  -> Con người xác nhận
  -> Ghi evidence
```

- Không chỉnh Swift code trước khi xác định spec/task và ngữ cảnh liên quan.
- Không chấp nhận đầu ra AI nếu chưa qua kiểm chứng phù hợp.

## Verification And AI4SE Evidence

- Với thay đổi code, ưu tiên chạy Xcode build theo lệnh trong `NutriQuor/AGENTS.md`.
- Với thay đổi API/decode, phải đối chiếu Backend API contract, Swift DTO và service mapping.
- Với thay đổi UI, phải kiểm tra trạng thái đang xử lý, thành công, rỗng và lỗi nếu chức năng có luồng bất đồng bộ.
- Với mọi task AI4SE quan trọng, phải ghi evidence gồm context, prompt summary, file thay đổi, verification, lỗi phát hiện, chỉnh sửa và xác nhận của con người.

## Governance

Constitution này là ràng buộc chính cho mọi spec/plan/task của app. Nếu API contract
thay đổi, spec app và spec Backend API liên quan phải được đối chiếu.

**Version**: 1.1.0 | **Ratified**: 2026-08-13 | **Last Amended**: 2026-08-25
