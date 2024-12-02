//
//  EntityQuery.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift


class EntityQuery: Object {
    @Persisted(primaryKey: true) var query: String
    @Persisted var photos = List<EntityPhoto>()
    
    convenience init(query: String, photos: [EntityPhoto]) {
        self.init()
        self.query = query
        self.photos.append(objectsIn: photos)
    }
    
}
