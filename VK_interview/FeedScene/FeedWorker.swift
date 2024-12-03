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
        let query = parameters.requestParameters
        // fix it
        let queryName = parameters.query + String(parameters.page) + (parameters.color ?? "")
        
        if let data = try await repository.getPhotos(query: queryName) {
            return data
        }
        
        let photo = try await fetcher.getPhotos(parameters: query)
        
        Task.detached(priority: .low) {
            print("start")
            await self.repository.savePhotos(query: queryName, photo)
            print("end")
        }
        
        return photo
    }
    
    
}
