//
//  FeedInteractor.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

protocol FeedBusinessLogic {
    func doSomething(request: Feed.Something.Request)
}

actor Repository {
    
    private var dataPhoto: [Photo] = []
    
    func setItems(_ items: [Photo]) {
        dataPhoto = items
    }
    
    func addItem(_ items: [Photo]) {
        dataPhoto += items
    }
    
    func getItems() -> [Photo] {
        dataPhoto
    }
    
}

class FeedInteractor: FeedBusinessLogic {
    
    var presenter: FeedPresentationLogic?
    var worker: FeedWorker!
    
    // State
    
    var query: ConfigurationQuery? = nil
    
    var repo = Repository()
    
    // MARK: Do something
    
    func doSomething(request: Feed.Something.Request) {
        if worker === nil { worker = FeedWorker() }
        
        switch request {
        case .search(parameters: let parameters):
            query = parameters
            Task {
                do {
                    let photos = try await worker.getPhotos(parameters: parameters)
                    await self.presenter?.presentSomething(response: .presentPhotos(photos: photos))
                    await self.repo.setItems(photos)
                } catch {
                    await self.presenter?.presentSomething(response: .presentError(error: error))
                }
            }
        case .nextPage:
            guard query != nil else { return }
            query!.page += 1
            Task {
                await self.presenter?.presentSomething(response: .presentFooterLoader)
            }
            Task {
                do {
                    let newPhotos = try await worker.getPhotos(parameters: query!)
                    await self.presenter?.presentSomething(response: .presentPhotos(photos: newPhotos, new: false))
                    await self.repo.addItem(newPhotos)
                } catch {
                    await self.presenter?.presentSomething(response: .presentError(error: error))
                }
            }
        }
    }
}
