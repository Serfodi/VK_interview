//
//  FeedViewControllerTests.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

@testable import VK_interview
import XCTest
import Combine

class FeedViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: FeedViewController!
    var window: UIWindow!
    var store: Set<AnyCancellable> = []
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupFeedViewController()
    }
    
    override func tearDown() {
        window = nil
        store.removeAll()
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupFeedViewController() {
        sut =  FeedViewController()
    }
    
    @MainActor func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class FeedBusinessLogicSpy: FeedBusinessLogic {
        var doSomethingCalled = false
        
        func doSomething(request: Feed.Something.Request) {
            doSomethingCalled = true
        }
    }
    
    // MARK: Tests
        
    func testDisplayCells() async throws {
        let displayCells = [MockData.mockPhotoDisplayCell]
        
        let viewModel = Feed.Something.ViewModel.displayPhotosCell(photos: displayCells)
        
        var valueTest: Bool = true
        await sut.collectionView.isLoad.sink { value in
            valueTest = value
        }.store(in: &store)
        
        // When
        await loadView()
        await sut.displaySomething(viewModel: viewModel)
        
        let count = await sut.collectionView.visibleCells.count
        
        // Then
        XCTAssert(count > 0, "Collection has not been reload")
        XCTAssertFalse(valueTest, "Dont hide load because not send False")
    }
    
    func testDisplayLoad() async throws {
        let viewModel = Feed.Something.ViewModel.displayFooterLoader
        
        var valueTest: Bool = false
        await sut.collectionView.isLoad.sink { value in
            valueTest = value
        }.store(in: &store)
        
        // When
        await loadView()
        await sut.displaySomething(viewModel: viewModel)
        
        // Then
        XCTAssertTrue(valueTest, "Dont show load because not send True")
    }
    
}
