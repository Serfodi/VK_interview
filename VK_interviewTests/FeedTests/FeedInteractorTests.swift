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
        
        func presentSomething(response: Feed.Something.Response) {
            presentSomethingCalled = true
        }
    }
    
    // MARK: Tests
    
    func testDoSomething() {
        // Given
        let spy = FeedPresentationLogicSpy()
        sut.presenter = spy
        let request = Feed.Something.Request()
        
        // When
        sut.doSomething(request: request)
        
        // Then
        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
    }
}
