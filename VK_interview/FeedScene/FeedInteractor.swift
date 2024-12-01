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

protocol FeedDataStore {
    //var name: String { get set }
}

class FeedInteractor: FeedBusinessLogic, FeedDataStore {
    var presenter: FeedPresentationLogic?
    var worker: FeedWorker!
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Feed.Something.Request) {
        if worker === nil { worker = FeedWorker() }
        
        //presenter?.presentSomething(response: response)
    }
}
