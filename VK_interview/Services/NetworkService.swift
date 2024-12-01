//
//  NetworkService.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String]) async throws -> Data
}

final class NetworkService: Networking {
    
    func request(path: String, params: [String : String]) async throws -> Data {
        let url = self.url(path: path, params: params)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Client-ID \(API.accessKey)"]
        let (data, response) = try await URLSession.shared.data(for: request)
        try statusCode(response)
        return data
    }
    
    private func url(path: String, params: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        if !params.isEmpty {
            components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        }
        return components.url!
    }
    
    private func statusCode(_ response: URLResponse) throws {
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                return
            case 400...499:
                throw HTTPStatusCode(rawValue: httpResponse.statusCode) ?? HTTPStatusCode.undefine
            case 500...599:
                throw HTTPStatusCode.serversError
            default:
                throw HTTPStatusCode.undefine
            }
        }
    }
    
}
