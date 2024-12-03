//
//  NetworkDataFetcherTests.swift
//  VK_interviewTests
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import XCTest
@testable import VK_interview

final class NetworkDataFetcherTests: XCTestCase {
    
    var sut: NetworkDataFetcher!
    var mockNetworkingService: MockNetworkingService!
    
    override func setUpWithError() throws {
        super.setUp()
        mockNetworkingService = MockNetworkingService()
        sut = NetworkDataFetcher(networking: mockNetworkingService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockNetworkingService = nil
        super.tearDown()
    }
    
    func testGetPhotosReturnsPhotos() async throws {
        let expectedPhotos = [MockData.mockPhoto]
        let jsonData = MockData.mockJson
        
        mockNetworkingService.mockData = jsonData
        let photos = try await sut.getPhotos(parameters: [:])
        
        XCTAssertEqual(photos.count, expectedPhotos.count)
        XCTAssertEqual(photos.first?.id, expectedPhotos.first?.id)
    }
    
    func testGetPhotosHandlesError() async throws {
        mockNetworkingService.mockError = DataError.notData
        do {
            _ = try await sut.getPhotos(parameters: [:])
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertEqual(error as? DataError, DataError.notData)
        }
    }
    
}


// MARK: - MOCK

class MockNetworkingService: Networking {
    var mockData: Data?
    var mockError: Error?
    
    func request(path: String, params: [String : String]) async throws -> Data {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw DataError.notData // Use your actual error handling here
        }
        return data
    }
}
