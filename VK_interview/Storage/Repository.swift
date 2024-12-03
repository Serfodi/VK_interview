//
//  Repository.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift


protocol Repository {
    func getPhotos(query key: String) async throws -> [Photo]?
    func savePhotos(query: String, _ data: [Photo]) async
    func clearAll() async
}

final class PhotoRepository: Repository {
    
    private let storage: StorageService
    
    init(storage: StorageService = StorageService()) {
        self.storage = storage
    }
    
    func getPhotos(query key: String) async throws -> [Photo]? {
        let data = try await storage.get(ofType: EntityQuery.self, forPrimaryKey: key)
        return data?.photos.map { Photo($0) }
    }
    
    func savePhotos(query: String, _ data: [Photo]) async {
        let objects = data.map(EntityPhoto.init)
        let obj = EntityQuery(query: query, photos: objects)
        try? await storage.save(object: obj)
    }

    func clearAll() async {
        try? await storage.deleteAll()
    }
    
}
