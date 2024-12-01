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
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
