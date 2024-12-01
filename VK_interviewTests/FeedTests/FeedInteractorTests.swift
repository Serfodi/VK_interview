//
//  FeedInteractorTests.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

@testable import VK_interview
import XCTest

class FeedInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: FeedInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupFeedInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupFeedInteractor() {
        sut = FeedInteractor()
    }
    
    // MARK: Test doubles
    
    class FeedPresentationLogicSpy: FeedPresentationLogic {
        var presentSomethingCalled = false
        var photo: Photo? = nil
        var error: Error? = nil
        
        func presentSomething(response: Feed.Something.Response) {
            presentSomethingCalled = true
            switch response {
            case .presentPhotos(photos: let photos):
                self.photo = photos.first
            case .presentError(error: let error):
                self.error = error
            }
        }
    }
    
    // MARK: Tests
    
    func testDoSomething() async throws {
        // Given
        let spy = FeedPresentationLogicSpy()
        sut.presenter = spy
        
        let configurationQuery = ConfigurationQuery(query: "cat")
        let request = Feed.Something.Request.search(parameters: configurationQuery)
        
        let expectation = self.expectation(description: "load result query")
        
        // When
        sut.doSomething(request: request)
        
        Task {
            while !spy.presentSomethingCalled {
                try await Task.sleep(nanoseconds: 100_000_000)
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
        XCTAssertNotNil(spy.photo)
    }
}
