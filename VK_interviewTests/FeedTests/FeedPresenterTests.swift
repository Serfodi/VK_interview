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
        var photoDisplayCell: [PhotoDisplayCell] = []
        var error: String? = nil
        var isLoadShow = false
        
        func displaySomething(viewModel: Feed.Something.ViewModel) {
            displaySomethingCalled = true
            switch viewModel {
            case .displayPhotosCell(photos: let photos):
                photoDisplayCell = photos
            case .displayError(error: let error):
                self.error = error
            case .displayFooterLoader:
                self.isLoadShow = true
            }
        }
    }
    
    // MARK: Tests
    
    func testPresentPhotosSearch() async throws {
        // Given
        let spy = FeedDisplayLogicSpy()
        sut.viewController = spy
        
        let response = Feed.Something.Response.presentPhotos(photos: MockData.mockPhotos, new: true)
        
        await sut.presentSomething(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spy.photoDisplayCell.count, 1, "Does not update the data [Photos]")
    }
    
    func testPresentPhotosNewPage() async throws {
        // Given
        let spy = FeedDisplayLogicSpy()
        sut.viewController = spy
        sut.photoDisplay = [MockData.mockPhotoDisplayCell]
        
        let response = Feed.Something.Response.presentPhotos(photos: MockData.mockPhotos, new: false)
        
        await sut.presentSomething(response: response)
        
        // Then
        XCTAssertEqual(spy.photoDisplayCell.count, 2, "Does not add the data [Photos]")
    }
    
    func testPresentError() async throws {
        let spy = FeedDisplayLogicSpy()
        sut.viewController = spy
        
        let response = Feed.Something.Response.presentError(error: DataError.notData)
        
        await sut.presentSomething(response: response)
        
        // Then
        XCTAssertNotNil(spy.error, "The error was not present")
    }
    
    func testPresentLoader() async throws {
        let spy = FeedDisplayLogicSpy()
        sut.viewController = spy
        
        let response = Feed.Something.Response.presentFooterLoader
        
        await sut.presentSomething(response: response)
        
        // Then
        XCTAssertTrue(spy.isLoadShow, "The error was not present")
    }
    
}
