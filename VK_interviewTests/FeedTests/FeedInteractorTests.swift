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
        sut = nil
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
        var isLoadShow = false
        var isLoadHide = false
        var isNew: Bool? = nil
        var alert: Bool = false
        var (head, text) = ("", "")
        
        func presentSomething(response: Feed.Something.Response) {
            presentSomethingCalled = true
            switch response {
            case .presentPhotos(photos: let photos, new: let new):
                isNew = new
                isLoadHide = true
                self.photo = photos.first
            case .presentError(error: let error):
                self.error = error
            case .presentFooterLoader:
                isLoadShow = true
            case .presentAlert(header: let header, text: let text):
                alert = true
                (head, self.text) = (header, text ?? "")
            }
        }
    }
    
    // MARK: Tests
    
    func testDoSomethingSearch() async throws {
        let spy = FeedPresentationLogicSpy()
        sut.presenter = spy
        
        var work =  MockWorker()
        work.data = [MockData.mockPhoto]
        sut.worker = work
        
        let query = ConfigurationQuery(query: "cat")
        
        // When
        let expectation = self.expectation(description: "async")
        let task = Task {
            sut.doSomething(request: .search(parameters: query))
            expectation.fulfill()
        }
        await task.value
        await fulfillment(of: [expectation], timeout: 1)
        
        // Then
        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
        XCTAssertNotNil(spy.photo)
        XCTAssertNotNil(sut.query)
    }
    
    
    func testDoSomethingNextPage() async throws {
        let spy = FeedPresentationLogicSpy()
        sut.presenter = spy
        sut.query = ConfigurationQuery(query: "cat")
        let request = Feed.Something.Request.nextPage
        
        // When
        let expectation = self.expectation(description: "async")
        let task = Task {
            sut.doSomething(request: request)
            expectation.fulfill()
        }
        await task.value
        await fulfillment(of: [expectation], timeout: 1)
        sleep(1) // 🤡
        
        // Then
        XCTAssertTrue(spy.isLoadShow)
        XCTAssertTrue(spy.isLoadHide)
        XCTAssertEqual(sut.query?.page, 2)
    }
    
    func testDoSomethingError() async throws {
        let spy = FeedPresentationLogicSpy()
        sut.presenter = spy
        var work = MockWorker()
        work.error = DataError.notData
        sut.worker = work
        let query = ConfigurationQuery(query: "cat")
        let request = Feed.Something.Request.search(parameters: query)
        
        // When
        let expectation = self.expectation(description: "async")
        let task = Task {
            sut.doSomething(request: request)
            expectation.fulfill()
        }
        await task.value
        await fulfillment(of: [expectation], timeout: 1)
        
        // Then
        XCTAssertNotNil(spy.error)
    }
    
}

class MockWorker: FeedWorker {
    
    var error: Error?
    var data: [Photo]?
    
    override func getPhotos(parameters: ConfigurationQuery) async throws -> [Photo] {
        
        if let error {
            throw error
        }
        
        return data!
    }
    
}
