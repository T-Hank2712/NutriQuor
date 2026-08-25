# AGENTS.md - NutriQuor

File này hướng dẫn AI agent khi làm việc trong project iOS `NutriQuor`. Luôn đọc file root `../AGENTS.md` trước, sau đó đọc file này để nắm quy tắc riêng của app.

## Project Role

`NutriQuor` là ứng dụng iOS của hệ thống ViFood/NutriQuor. App cho phép người dùng đăng ký, đăng nhập, chụp hoặc chọn ảnh nhãn thực phẩm, gửi ảnh phân tích, xem kết quả, xem lịch sử và tra cứu chi tiết tri thức.

## Architecture Rules

- App chỉ gọi `ViFood-API`.
- App không gọi trực tiếp `LLM-KIE 2`, `ViFood-KG-Builder`, S3, MongoDB hoặc Neo4j.
- App không chứa secret của backend, storage, graph, AIaaS hoặc model provider.
- App không tự chạy AI, không entity linking và không tự tạo kết luận y tế/an toàn thực phẩm.
- App hiển thị dữ liệu backend trả về, không tự suy diễn dữ liệu không có trong response.

## Expected Stack And Structure

- Language: Swift.
- UI: SwiftUI.
- Architecture: MVVM.
- Networking: URLSession, async/await, REST API.
- Auth: bearer token, refresh token.

Các vùng code chính:

- `NutriQuor/API`: tạo request đến backend.
- `NutriQuor/Core/Network`: API client, interceptor, networking.
- `NutriQuor/Core/Services`: service gọi API.
- `NutriQuor/Features`: màn hình theo domain.
- `NutriQuor/Models`: DTO/domain model.
- `NutriQuor/ViewModels`: state và logic UI.
- `NutriQuor/Storages`: lưu token hoặc state cục bộ.

## API Rules

- Base URL backend nằm trong cấu hình app, không hard-code rải rác.
- Request cần auth phải gắn `Authorization: Bearer <token>`.
- Upload ảnh phân tích phải gọi backend endpoint `/products/extract`.
- App decode response thành công theo envelope `{ message, data }`.
- Error public từ backend phải được map thành thông báo dễ hiểu.
- Khi item result có `id`, app cho phép mở detail.
- Khi item không có `id`, app hiển thị text và không gọi detail sai.
- App không cần biết Backend API gọi Builder hay Builder gọi AIaaS như thế nào.

## UI Rules

- Màn hình scan phải có preview trước khi gửi ảnh.
- Luồng phân tích phải có loading, success và error state.
- Result UI hiển thị theo nhóm: product name, ingredients, additives, nutritions, warning, manufacturer, dates, net weight, origin.
- History UI chỉ hiển thị dữ liệu của user đang đăng nhập theo response backend.
- Search/detail UI không trình bày thông tin như tư vấn y tế hoặc kết luận tuyệt đối.

## RTK Rules

RTK là công cụ phụ trợ bắt buộc để rút gọn output terminal cho Codex/AI agent. RTK không phải dependency của app iOS.

- Luôn luôn prefix lệnh shell bằng `rtk` khi chạy command phục vụ đọc code, tìm kiếm, test, build, lint, log, git hoặc diagnostics.
- Dùng `rtk proxy <cmd>` khi cần output đầy đủ hoặc khi RTK lọc thiếu thông tin cần debug.
- Chỉ được chạy lệnh gốc không qua `rtk` khi RTK lỗi, không hỗ trợ command tương tác/đặc biệt, hoặc cần output thô để debug. Khi fallback, agent phải ghi rõ lý do.

## Testing And Verification

Khi thay đổi app, kiểm chứng phù hợp bằng Xcode hoặc command:

```bash
rtk env DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
xcodebuild \
  -project NutriQuor.xcodeproj \
  -scheme "NutriQuor 1" \
  -configuration Debug \
  -destination generic/platform=iOS \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Kiểm tra thủ công các flow chính:

- Đăng ký/đăng nhập.
- Scan/chọn ảnh và preview.
- Upload ảnh đến backend.
- Hiển thị result.
- Mở detail từ item có ID.
- Xem history.
- Search nutrient/additive/ingredient.
- Xử lý lỗi backend/unauthorized/network.

## Do Not

- Không thêm kết nối trực tiếp đến AIaaS, Builder, S3, MongoDB hoặc Neo4j.
- Không lưu access token ở nơi kém an toàn hơn pattern đang dùng.
- Không hard-code secret.
- Không hiển thị JSON thô cho người dùng.
- Không tạo dữ liệu giả cho field backend không trả.
