//
//  User.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

struct User: Decodable {
    
    struct ProfileImageSize: Decodable {
        let small: String
    }
    
    struct Links: Decodable {
        let html: String
    }
    
    let id: String
    let username: String
    let profileImage: ProfileImageSize
    let links: Links?
    let instagramUsername: String?
    let twitterUsername: String?
    
}
