//
//  NetworkDataFetcher.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

protocol DataFetcher {
    func getPhotos(parameters:[String:String]) async throws -> [Photo]
}

class NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    /// Photo Search request Get
    ///
    /// - Invariant: endpoint `API.searchPhotos = /search/photos`
    ///
    /// Parameters:
    ///  * query – Search terms
    ///  * page – Page number to retrieve. (Optional; default: 1)
    ///  * per_page – Number of items per page. (Optional; default: 10)
    ///
    /// - seealso: Find more information for [Unsplash Developers](https://unsplash.com/documentation#search-photos)
    ///
    func getPhotos(parameters: [String : String]) async throws -> [Photo] {
        let data = try await networking.request(path: API.searchPhotos, params: parameters)
        let decoded = self.decoderJSON(type: ResponseWrapped<Photo>.self, from: data)
        guard let result = decoded?.results else { throw DataError.notData }
        return result
    }
    
    private func decoderJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = from,
            let response = try? decoder.decode(type.self, from: data)
        else { return nil }
        return response
    }
    
}
