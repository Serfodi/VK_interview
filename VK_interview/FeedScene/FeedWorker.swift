//
//  FeedWorker.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class FeedWorker {
    
    var fetcher: DataFetcher
    var repository: Repository
    
    init() {
        self.fetcher = NetworkDataFetcher(networking: NetworkService())
        self.repository = PhotoRepository(storage: StorageService(.defaultConfiguration))
    }
    
    func getPhotos(parameters: ConfigurationQuery) async throws -> [Photo] {
        
//        let query = parameters.requestParameters.values.reduce("", +)
//        if let data = repository.getPhotos(query: query) {
//            return data
//        }
        
        let photo = try await fetcher.getPhotos(parameters: parameters.requestParameters)
        
//        Task.detached(priority: .low) {
//            await self.repository.savePhotos(query: query, photo)
//        }
        
        return photo
    }
    
}
