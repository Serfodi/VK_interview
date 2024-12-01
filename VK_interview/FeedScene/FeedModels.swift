//
//  FeedModels.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

enum Feed {
    
    // MARK: Use cases
    
    enum Something {
        enum Request {
            case search(parameters: ConfigurationQuery)
        }
        enum Response {
            case presentPhotos(photos: [Photo])
            case presentError(error: Error)
        }
        enum ViewModel {
            case displayPhotosCell(photos: [PhotoDisplayCell])
            case displayError(error: String)
        }
    }
}