# RTK - Rust Token Killer

RTK là công cụ phụ trợ cho Codex/AI agent khi chạy lệnh trong project `NutriQuor`. RTK giúp rút gọn output build/test để giảm nhiễu log.

RTK không phải dependency của app iOS và không nằm trong runtime của người dùng.

## Rule

Ưu tiên prefix các lệnh shell bằng `rtk`.

```bash
rtk git status
rtk xcodebuild -version
rtk env DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project NutriQuor.xcodeproj -scheme "NutriQuor 1" -configuration Debug -destination generic/platform=iOS CODE_SIGNING_ALLOWED=NO build
```

## Khi Cần Output Đầy Đủ

```bash
rtk proxy xcodebuild -version
```

## Verification

```bash
rtk --version
rtk gain
which rtk
```

