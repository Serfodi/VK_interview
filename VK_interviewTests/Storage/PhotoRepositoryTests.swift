//
//  PhotoRepositoryTests.swift
//  VK_interviewTests
//
//  Created by Сергей Насыбуллин on 04.12.2024.
//

@testable import VK_interview
import XCTest
import RealmSwift

final class PhotoRepositoryTests: XCTestCase {

    
    
    override func setUpWithError() throws {
        super.setUp()
        
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }

//    func testSave() async throws {
//        let key = "cat"
//        let photos = [MockData.mockPhoto]
//        
//        var config = Realm.Configuration()
//        config.inMemoryIdentifier = self.name
//        let sut = PhotoRepository(storage: StorageService(config ))
//
//        await sut.savePhotos(query: key, photos)
//        
//        let getPhotos = try await sut.getPhotos(query: key)
//        
//        XCTAssertEqual(photos[0].id, getPhotos?[0].id)
//        
//        await sut.clearAll()
//        
//        let getPhotosClear = try await sut.getPhotos(query: key)
//        
//        XCTAssertNil(getPhotosClear)
//    }

}
