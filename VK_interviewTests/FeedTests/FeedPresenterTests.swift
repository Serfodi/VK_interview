//
//  FeedPresenterTests.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

@testable import VK_interview
import XCTest

class FeedPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: FeedPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupFeedPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupFeedPresenter() {
        sut = FeedPresenter()
    }
    
    // MARK: Test doubles
    
    class FeedDisplayLogicSpy: FeedDisplayLogic {
        var displaySomethingCalled = false
        var photoDisplayCell: PhotoDisplayCell? = nil
        var error: String? = nil
        
        func displaySomething(viewModel: Feed.Something.ViewModel) {
            displaySomethingCalled = true
            switch viewModel {
            case .displayPhotosCell(photos: let photos):
                photoDisplayCell = photos.first
            case .displayError(error: let error):
                self.error = error
            }
        }
    }
    
    // MARK: Tests
    
    func testPresentSomething() async throws {
        // Given
        let spy = FeedDisplayLogicSpy()
        sut.viewController = spy
        
        let expectedUser = User(id: "1", username: "bar", profileImage: .init(small: "small"), links: nil, instagramUsername: nil, twitterUsername: nil)
        let expectedPhotos = [Photo(id: "1",
                                    width: 100, height: 100,
                                    createdAt: Date(timeIntervalSince1970: 100),
                                    description: "foo", user: expectedUser,
                                    urls: .init(small: "small", regular: "regular", full: "full", thumb: "thumb"),
                                    likes: 100)]
        
        let response = Feed.Something.Response.presentPhotos(photos: expectedPhotos)
        
        let expectation = self.expectation(description: "load result query")
        
        // When
        sut.presentSomething(response: response)
        
        Task {
            while !spy.displaySomethingCalled {
                try await Task.sleep(nanoseconds: 100_000_000)
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
        
        
        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertNotNil(spy.photoDisplayCell, "error convert photo in PhotoDisplayCell")
    }
}
