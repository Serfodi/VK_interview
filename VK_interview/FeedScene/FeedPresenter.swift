//
//  FeedPresenter.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

protocol FeedPresentationLogic {
    func presentSomething(response: Feed.Something.Response) async
}

class FeedPresenter: FeedPresentationLogic {
    
    weak var viewController: FeedDisplayLogic?
    
    let calculate = CalculateCellSize()
    var photoDisplay = [PhotoDisplayCell]()
    
    // MARK: Do something
    
    func presentSomething(response: Feed.Something.Response) async {
        switch response {
        case .presentPhotos(photos: let photos, new: let new):
            let photosCell = await prepareMedia(photos)
            if new {
                photoDisplay = photosCell
            } else {
                photoDisplay += photosCell
            }
            await viewController?.displaySomething(viewModel: .displayPhotosCell(photos: photoDisplay))
        case .presentFooterLoader:
            await viewController?.displaySomething(viewModel: .displayFooterLoader)
        case .presentError(error: let error):
            await viewController?.displaySomething(viewModel: .displayAlert(header: "Error".localized(), text: error.localizedDescription))
        case .presentAlert(header: let header, text: let text):
            await viewController?.displaySomething(viewModel: .displayAlert(header: header, text: text))
        }
    }
}

private extension FeedPresenter {
        
    func prepareMedia(_ photos: [Photo]) async -> [PhotoDisplayCell] {
        await withTaskGroup(of: PhotoDisplayCell?.self) { group in
            for photo in photos {
                group.addTask {
                    self.convert(photo)
                }
            }
            var results: [PhotoDisplayCell] = []
            for await result in group {
                if let cell = result {
                    results.append(cell)
                }
            }
            return results
        }
    }
    
    func convert(_ photo: Photo) -> PhotoDisplayCell {
        let size = calculate.sizes(description: photo.description, photo: CGSize(width: photo.width, height: photo.height))
        let photoUrlString: String = photo.urls?.small ?? ""
        return PhotoDisplayCell(id: photo.id,
                                imageURL: photoUrlString,
                                description: photo.description,
                                userImage: photo.user?.profileImage.small ?? "",
                                userName: photo.user?.username ?? "",
                                size: size,
                                date: photo.createdAt,
                                like: photo.likes)
    }
    
}
