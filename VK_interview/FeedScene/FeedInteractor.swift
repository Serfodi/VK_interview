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
    
    // MARK: Do something
    
    func doSomething(request: Feed.Something.Request) {
        if worker === nil { worker = FeedWorker() }
        
        switch request {
        case .search(parameters: let parameters):
            Task(priority: .userInitiated) {
                do {
                    let photos = try await worker.getPhotos(parameters: parameters)
                    self.presenter?.presentSomething(response: .presentPhotos(photos: photos))
                } catch {
                    self.presenter?.presentSomething(response: .presentError(error: error))
                }
            }
        }
        
    }
}
