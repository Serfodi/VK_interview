//
//  WebImageView.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class WebImageView: UIImageView {
    
    private var downloadTask: Task<(), any Error>?
    
    func asyncSetImage(url: URL) {
        downloadTask = Task(priority: .high) {
            let image = try? await DownloadImage().load(url: url)
            self.image = image
        }
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
    }
    
}
