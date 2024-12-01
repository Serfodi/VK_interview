//
//  FeedPresenter.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

protocol FeedPresentationLogic {
    func presentSomething(response: Feed.Something.Response)
}

class FeedPresenter: FeedPresentationLogic {
    
    weak var viewController: FeedDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Feed.Something.Response) {
        switch response {
        case .presentPhotos(photos: let photos):
            let photosCell = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayPhotosCell(photos: photosCell))
            }
        case .presentError(error: let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayError(error: error.localizedDescription))
            }
        case .presentFooterLoader:
            Task {
                await viewController?.displaySomething(viewModel: .displayFooterLoader)
            }
        }
    }
}

private extension FeedPresenter {
    
    func prepareMedia(_ photos: [Photo]) -> [PhotoDisplayCell] {
        photos.map(convert)
    }
    
    func convert(from photo: Photo) -> PhotoDisplayCell {
        let size = CalculateCellSize().sizes(description: photo.description, photo: CGSize(width: photo.width, height: photo.height))
        let photoUrlString: String = photo.urls.small
        return PhotoDisplayCell(id: photo.id,
                              imageURL: photoUrlString,
                              description: photo.description,
                              user: photo.user,
                              size: size,
                              date: photo.createdAt ?? Date(),
                              like: photo.likes ?? 0)
    }
    
}
