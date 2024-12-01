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
    
    var dataPhoto: [Photo] = []
    
    // MARK: Do something
    
    func doSomething(request: Feed.Something.Request) {
        if worker === nil { worker = FeedWorker() }
        
        switch request {
        case .search(parameters: let parameters):
            query = parameters
            Task(priority: .userInitiated) {
                do {
                    let photos = try await worker.getPhotos(parameters: parameters)
                    
                    // load photos into Repository for cash
                    
                    self.dataPhoto = photos
                    
                    self.presenter?.presentSomething(response: .presentPhotos(photos: photos))
                } catch {
                    self.presenter?.presentSomething(response: .presentError(error: error))
                }
            }
        case .nextPage:
            guard query != nil else { return }
            query!.page += 1
            self.presenter?.presentSomething(response: .presentFooterLoader)
            Task(priority: .userInitiated) {
                do {
                    let photos = try await worker.getPhotos(parameters: query!)
                    
                    // load photos into Repository for cash
                    
                    self.dataPhoto += photos
                    
                    self.presenter?.presentSomething(response: .presentPhotos(photos: dataPhoto))
                } catch {
                    self.presenter?.presentSomething(response: .presentError(error: error))
                }
            }
        }
        
    }
}
