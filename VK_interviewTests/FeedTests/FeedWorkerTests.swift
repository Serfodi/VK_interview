//
//  FeedWorkerTests.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

@testable import VK_interview
import XCTest

class FeedWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: FeedWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupFeedWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupFeedWorker() {
        sut = FeedWorker()
    }
    
    // MARK: Test doubles
    
    class MockDataFetcher: DataFetcher {
        func getPhotos(parameters: [String : String]) async throws -> [Photo] {
            [MockData.mockPhoto, MockData.mockPhoto]
        }
    }
    
    class MockPhotoRepository: PhotoRepository {
        
        var store: [String:[Photo]] = [:]
        
        override func getPhotos(query key: String) async throws -> [Photo]? {
            store[key]
        }
        
        override func savePhotos(query: String, _ data: [Photo]) async {
            store[query] = data
        }
    }
    
    // MARK: Tests
    
    func testGetPhotosFromFetchData() async throws {
        // Given
        let query = ConfigurationQuery(query: "cat")
        
        sut.fetcher = MockDataFetcher()
        sut.repository = MockPhotoRepository()
        
        // When
        let photo = try await sut.getPhotos(parameters: query)
        
        // Then
        XCTAssertEqual(photo.count, 2, "The photo must be uploaded from the network")
    }
    
    func testGetPhotosFromRepository() async throws {
        // Given
        let query = ConfigurationQuery(query: "cat")
        let photos = [MockData.mockPhoto]
        
        let repo = MockPhotoRepository()
        repo.store[query.generateKey] = photos
        
        sut.fetcher = MockDataFetcher()
        sut.repository = repo
        
        // When
        let photo = try await sut.getPhotos(parameters: query)
        
        // Then
        XCTAssertEqual(photo.count, 1, "The photo must be uploaded from the storage")
    }
    
}
 
 
