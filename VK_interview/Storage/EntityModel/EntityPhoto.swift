//
//  EntityPhoto.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift

// fix it
class EntityPhoto: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var width: Int
    @Persisted var height: Int
    @Persisted var createdAt: Date
    @Persisted var photoDescription: String?
    @Persisted var likes: Int
    @Persisted var smallImage: String
    @Persisted var regularImage: String
    @Persisted var username: String
    @Persisted var profileImage: String
}

// MARK: - Entity Photo

extension EntityPhoto {
    convenience init(_ photo: Photo) {
        self.init()
        id = photo.id
        width = photo.width
        height = photo.height
        createdAt = photo.createdAt
        photoDescription = photo.description
        username = photo.user?.username ?? ""
        profileImage = photo.user?.profileImage.small ?? ""
        smallImage = photo.urls?.small ?? ""
        regularImage = photo.urls?.regular ?? ""
        likes = photo.likes
    }
}

// MARK: - Photo

extension Photo {
    
    init(_ entity: EntityPhoto) {
        self.id = entity.id
        self.width = entity.width
        self.height = entity.height
        self.createdAt = entity.createdAt
        self.description = entity.photoDescription
        self.user = User(username: entity.username,
                         profileImage: User.ProfileImageSize(small: entity.profileImage))
        self.urls = UrlsSize(small: entity.smallImage,
                             regular: entity.regularImage)
        self.likes = entity.likes
    }
    
}
