//
//  FeedViewControllerTests.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

@testable import VK_interview
import XCTest

class FeedViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: FeedViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupFeedViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupFeedViewController() {
        sut =  FeedViewController()
    }
    
    func loadView() {
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
    
//    func testShouldDoSomethingWhenViewIsLoaded() throws {
//        // Given
//        let spy = FeedBusinessLogicSpy()
//        sut.interactor = spy
//        
//        // When
//        loadView()
//        sut.interactor?.doSomething(request: .search(parameters: <#T##ConfigurationQuery#>))
//        
//        // Then
//        XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
//    }
    
    @MainActor func testDisplaySomething() {
        // Given
        
        struct PhotoSize: PhotoCellSize {
            var imageViewFrame: CGRect =  CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            var descriptionLabelFrame: CGRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            var viewInfo: CGRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            var profileViewFrame: CGRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            var totalSize: CGSize = CGSize(width: 100, height: 100)
        }
        
        let user = User(id: "1", username: "bar", profileImage: .init(small: "small"), links: nil, instagramUsername: nil, twitterUsername: nil)
        let displayCells = [
            PhotoDisplayCell(id: "1", imageURL: "", user: user, size: PhotoSize(), date: Date(), like: 1)
        ]
        let viewModel = Feed.Something.ViewModel.displayPhotosCell(photos: displayCells)
        
        // When
        loadView()
        sut.displaySomething(viewModel: viewModel)
        
        let count = sut.collectionView.visibleCells.count
        
        // Then
        XCTAssert(count > 0)
    }
}
