//
//  DownloadImage.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class DownloadImage {
    
    private let cache = ImageCache.cache
    
    func load(url: URL) async throws -> UIImage? {
        
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let _ = response.url, let image = UIImage(data: data) else { return nil }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        self.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        
        return image
    }
        
}
