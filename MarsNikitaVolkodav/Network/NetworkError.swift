import Foundation

enum NetworkError: Error {
    case badStatusCode
    case badURL
    case badServerResponse
    case noDataError
    case unknownError
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badStatusCode:
            return NSLocalizedString("networkError_badStatusCode", comment: "")
        case .badURL:
            return NSLocalizedString("networkError_badURL", comment: "")
        case .badServerResponse:
            return NSLocalizedString("networkError_badServerResponse", comment: "")
        case .noDataError:
            return NSLocalizedString("networkError_noDataError", comment: "")
        case .unknownError:
            return NSLocalizedString("networkError_unknownError", comment: "")
        case .badRequest:
            return NSLocalizedString("networkError_badRequest", comment: "")
        case .unauthorized:
            return NSLocalizedString("networkError_unauthorized", comment: "")
        case .forbidden:
            return NSLocalizedString("networkError_forbidden", comment: "")
        case .notFound:
            return NSLocalizedString("networkError_notFound", comment: "")
        case .internalServerError:
            return NSLocalizedString("networkError_internalServerError", comment: "")
        }
    }
}
