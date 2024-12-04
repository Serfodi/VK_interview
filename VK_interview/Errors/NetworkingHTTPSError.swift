//
//  Errors.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
}

enum HTTPStatusCode: Int, Error, LocalizedError {
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case undefine = 411
    
    case serversError = 500
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad Request: The request was unacceptable, often due to missing a required parameter"
        case .unauthorized:
            return "Unauthorized: Invalid Access Token"
        case .paymentRequired:
            return "Payment Required"
        case .forbidden:
            return "Forbidden: Missing permissions to perform request"
        case .notFound:
            return "Not Found: The requested resource doesn’t exist"
        case .methodNotAllowed:
            return "Method not allowed"
        case .notAcceptable:
            return "Not acceptable"
        case .proxyAuthenticationRequired:
            return "Proxy authentication required"
        case .requestTimeout:
            return "Request timout"
        case .conflict:
            return "Conflict"
        case .gone:
            return "Gone"
        case .undefine:
            return "Undefine"
        case .serversError:
            return "Error with Unsplash’s servers"
        }
    }
}
