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
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
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
    
    func testShouldDoSomethingWhenViewIsLoaded() {
        // Given
        let spy = FeedBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func testDisplaySomething() {
        // Given
        //let viewModel = Feed.Something.ViewModel()
        
        // When
        //loadView()
        //sut.displaySomething(viewModel: viewModel)
        
        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
    }
}
