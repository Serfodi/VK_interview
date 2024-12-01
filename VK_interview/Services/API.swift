//
//  API.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation


enum API {
    static let scheme = "https"
    static let host = "api.unsplash.com"
    
    // endpoints
    static let searchPhotos = "/search/photos"
    
    // keys
    static let accessKey =  Environment.accessKey
}
