//
//  FeedRouter.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

@objc protocol FeedRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FeedDataPassing {
//    var dataStore: FeedDataStore? { get }
}

class FeedRouter: NSObject, FeedRoutingLogic, FeedDataPassing {
    weak var viewController: FeedViewController?
//    var dataStore: FeedDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?) {}
    
    // MARK: Navigation
    
//    func navigateToSomewhere(source: FeedViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: Passing data
    
//    func passDataToSomewhere(source: FeedDataStore, destination: inout SomewhereDataStore) {
//      destination.name = source.name
//    }
}
