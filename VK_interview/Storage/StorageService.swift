//
//  StorageService.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift

final class StorageService {
    
    private let storage: Realm?
    
    init(_ configuration: Realm.Configuration = Realm.Configuration(inMemoryIdentifier: "inMemory")) {
        self.storage = try? Realm(configuration: configuration)
    }
    
    func asyncSaveObject(object: Object) throws {
        guard let storage else { return }
        storage.writeAsync {
            storage.add(object, update: .all)
        }
    }
    
    func delete(object: Object) throws {
        guard let storage else { return }
        try storage.write {
            storage.delete(object)
        }
    }
    
    func deleteAll() throws {
        guard let storage else { return }
        try storage.write {
            storage.deleteAll()
        }
    }
         
    func fetch<Element, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? where Element : Object {
        storage?.object(ofType: type, forPrimaryKey: key)
    }
    
}
