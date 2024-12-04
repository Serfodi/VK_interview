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

class FeedInteractor: FeedBusinessLogic {
    
    var presenter: FeedPresentationLogic?
    var worker: FeedWorker!
    
    // State
    var query: ConfigurationQuery? = nil
    
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
                } catch {
                    await self.presenter?.presentSomething(response: .presentError(error: error))
                }
            }
        case .clearStore:
            Task {
                await self.worker.clearRepository()
                await self.presenter?.presentSomething(response: .presentAlert(header: "It's clear!".localized(), text: "All cache has been deleted".localized()))
            }
        }
    }
}
