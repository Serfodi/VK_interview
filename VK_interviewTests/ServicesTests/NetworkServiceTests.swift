//
//  NetworkServiceTests.swift
//  VK_interviewTests
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import XCTest
@testable import VK_interview

final class NetworkServiceTests: XCTestCase {

    var sut: NetworkService!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testRequestReturnsDataFromApi() async throws {
        let parameters = ["query":"office"]
        let path = API.searchPhotos
        let data = try await sut.request(path: path, params: parameters)
        XCTAssertNotNil(data)
    }
    
}
