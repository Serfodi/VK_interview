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
        
    }
}
