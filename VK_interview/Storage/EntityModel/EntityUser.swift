//
//  EntityUser.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift

class EntityUser: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var username: String
    @Persisted var profileImage: EntityProfileImageSize?
    
    convenience init(_ user: User) {
        self.init()
        id = user.id
        self.username = user.username
        self.profileImage = EntityProfileImageSize(user.profileImage)
    }
}

class EntityProfileImageSize: Object, Decodable {
    @Persisted var small: String
    
    convenience init(_ profileImageSize: User.ProfileImageSize) {
        self.init()
        small = profileImageSize.small
    }
}

// MARK: - User

extension User {
    
    init(_ entity: EntityUser) {
        self.id = entity.id
        self.username = entity.username
        self.profileImage = User.ProfileImageSize(
            small: entity.profileImage?.small ?? ""
        )
    }
}
