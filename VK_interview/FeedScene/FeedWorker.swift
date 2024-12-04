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
        let key = parameters.generateKey
        
        if let data = try await repository.getPhotos(query: key) {
            return data
        }
        
        let photo = try await fetcher.getPhotos(parameters: query)
        
        Task.detached(priority: .background) {
            await self.repository.savePhotos(query: key, photo)
        }
        
        return photo
    }
    
    func clearRepository() async {
        await repository.clearAll()
    }
    
    func isClear() async -> Bool {
        await repository.isDataClear()
    }
    
}
