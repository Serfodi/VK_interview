//
//  MockData.swift
//  VK_interviewTests
//
//  Created by Сергей Насыбуллин on 03.12.2024.
//

import Foundation
@testable import VK_interview

class MockData {
    
    static let mockPhoto = Photo(
        id: "1",
        width: 100, height: 100,
        createdAt: Date(timeIntervalSince1970: 100),
        description: "foo",
        user: MockData.mockUser,
        urls: .init(small: "small", regular: "regular"),
        likes: 777
    )
    
    static let mockPhotoDisplayCell = PhotoDisplayCell(
        id: "1",
        imageURL: "",
        userImage: "",
        userName: "bee",
        size: MockPhotoSize(),
        date: Date(),
        like: 1
    )
    
    static let mockUser = User(username: "bar", profileImage: .init(small: "small"))
    static let mockPhotos = [MockData.mockPhoto]
    
    struct MockPhotoSize: PhotoCellSize {
        var viewInfoFrame: CGRect = .zero
        var imageViewFrame: CGRect =  CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        var descriptionLabelFrame: CGRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        var viewInfo: CGRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        var profileViewFrame: CGRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        var totalSize: CGSize = CGSize(width: 100, height: 100)
    }
    
    
    
    static let mockJson =
                """
                {
                    "results": [
                        {
                              "id": "1",
                              "created_at": "1970-01-01T00:01:40Z",
                              "width": 100,
                              "height": 100,
                              "likes": 100,
                              "description": "foo",
                              "user": {
                                "id": "1",
                                "username": "bar",
                                "profile_image": {
                                  "small": "small",
                                }
                              },
                              "urls": {
                                "full": "full",
                                "regular": "regular",
                                "small": "small",
                                "thumb": "thumb"
                              }
                            }
                    ]
                }
                """.data(using: .utf8)
    
}
