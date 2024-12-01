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
        
        func displaySomething(viewModel: Feed.Something.ViewModel)
        {
            displaySomethingCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentSomething() {
        // Given
        let spy = FeedDisplayLogicSpy()
        sut.viewController = spy
        //let response = Feed.Something.Response()
        
        // When
        //sut.presentSomething(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
