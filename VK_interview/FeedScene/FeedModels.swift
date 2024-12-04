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
            case nextPage
            case clearStore
        }
        enum Response {
            case presentPhotos(photos: [Photo], new: Bool = true)
            case presentFooterLoader
            case presentError(error: Error)
            case presentAlert(header: String, text: String?)
        }
        enum ViewModel {
            case displayPhotosCell(photos: [PhotoDisplayCell])
            case displayAlert(header: String, text: String?)
            case displayFooterLoader
        }
    }
}
