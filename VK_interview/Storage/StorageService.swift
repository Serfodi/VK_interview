//
//  StorageService.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift

final actor StorageService {
    
    private let configuration: Realm.Configuration
    
    init(_ configuration: Realm.Configuration = Realm.Configuration(inMemoryIdentifier: "inMemory")) {
        self.configuration = configuration
    }
    
    func save(object: Object) throws {
        let storage = try Realm(configuration: configuration)
        let hasPrimaryKey = object.objectSchema.primaryKeyProperty != nil
        try storage.write {
            hasPrimaryKey ? storage.add(object, update: .modified) : storage.add(object)
        }
    }
    
    func get<Element, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) throws -> Element? where Element : Object {
        let storage = try Realm(configuration: configuration)
        return storage.object(ofType: type, forPrimaryKey: key)
    }
    
    func deleteAll() throws {
        let storage = try Realm(configuration: configuration)
        try storage.write {
            storage.deleteAll()
        }
    }
    
}
