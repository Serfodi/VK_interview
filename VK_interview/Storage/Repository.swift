//
//  Repository.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift


protocol Repository {
    func getPhotos(query key: String) -> [Photo]?
    func savePhotos(query: String, _ data: [Photo]) async
    func clearAirportList() async
}

final class PhotoRepository: Repository {
    
    private let storage: StorageService
    
    init(storage: StorageService = StorageService()) {
        self.storage = storage
    }
    
    func getPhotos(query key: String) -> [Photo]? {
        let data = storage.fetch(ofType: EntityQuery.self, forPrimaryKey: key)
        guard let photos = (data.map { $0.photos }) else { return nil }
        return photos.map { Photo($0) }
    }
    
    func savePhotos(query: String, _ data: [Photo]) async {
        let objects = data.map(EntityPhoto.init)
        let query = EntityQuery(query: query, photos: objects)
        try? storage.asyncSaveObject(object: query)
    }
    
    func clearAirportList() async {
        try? storage.deleteAll()
    }
    
}
