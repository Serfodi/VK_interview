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
    
    
    
    // MARK: Tests
    
//    func testSomething() async throws {
//        // Given
//        let query = ConfigurationQuery(query: "cat")
//        
//        sut.fetcher = 
//        
//        // When
//        let photo = try await sut.getPhotos(parameters: query)
//        
//        // Then
//        XCTAssert(!photo.isEmpty)
//    }
    
}

// MARK: - MOCK

class MockDataFetcher: DataFetcher {
    var mockData: Photo!
    
    func getPhotos(parameters: [String : String]) async throws -> [Photo] {
        [mockData]
    }
    
}
