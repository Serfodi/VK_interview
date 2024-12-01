//
//  FeedWorker.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class FeedWorker {
    
    var fetcher: DataFetcher
    
    init() {
        self.fetcher = NetworkDataFetcher(networking: NetworkService())
    }
    
    func getPhotos(parameters: ConfigurationQuery) async throws -> [Photo] {
        try await fetcher.getPhotos(parameters: parameters.requestParameters)
    }
    
}
