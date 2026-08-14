import Foundation

enum UserMessageMapper {
    static func message(for error: Error) -> String {
        if let apiError = error as? APIError {
            return apiError.localizedDescription
        }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "Không có kết nối mạng. Vui lòng kiểm tra Internet và thử lại."
            case .timedOut:
                return "Kết nối quá lâu. Vui lòng thử lại."
            case .badURL:
                return "Địa chỉ dịch vụ chưa đúng. Vui lòng kiểm tra cấu hình ứng dụng."
            case .cannotConnectToHost, .networkConnectionLost:
                return "Không thể kết nối đến hệ thống. Vui lòng thử lại sau."
            case .userAuthenticationRequired:
                return "Vui lòng đăng nhập để tiếp tục."
            default:
                return "Đã có lỗi kết nối. Vui lòng thử lại."
            }
        }

        return "Đã có lỗi xảy ra. Vui lòng thử lại."
    }
}
