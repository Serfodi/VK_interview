//
//  EntityPhoto.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import Foundation
import RealmSwift

class EntityPhoto: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var width: Int
    @Persisted var height: Int
    @Persisted var createdAt: Date
    @Persisted var photoDescription: String?
    @Persisted var user: EntityUser?
    @Persisted var urls: EntityUrlsSize?
    @Persisted var likes: Int
}

class EntityUrlsSize: Object, Decodable {
    @Persisted var small: String
    @Persisted var regular: String
    @Persisted var full: String
    @Persisted var thumb: String
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
        if let userPhoto = photo.user {
            self.user = EntityUser(userPhoto)
        } else {
            self.user = nil
        }
        if let urlPhoto = photo.user {
            urls = EntityUrlsSize(value: urlPhoto)
        } else {
            urls = nil
        }
        likes = photo.likes
    }
}

extension EntityUrlsSize {
    convenience init(_ urlsSize: Photo.UrlsSize) {
        self.init()
        small = urlsSize.small
        regular = urlsSize.regular
        full = urlsSize.full
        thumb = urlsSize.thumb
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
        if let user = entity.user {
            self.user = User(user)
        } else {
            self.user = nil
        }
        if let urlPhoto = entity.urls {
            self.urls = Photo.UrlsSize(
                small: urlPhoto.small,
                regular: urlPhoto.regular,
                full: urlPhoto.full,
                thumb: urlPhoto.thumb
            )
        } else {
            self.urls = nil
        }
        self.likes = entity.likes
    }
    
}
