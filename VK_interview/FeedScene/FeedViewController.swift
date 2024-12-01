//
//  FeedViewController.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

protocol FeedDisplayLogic: AnyObject {
    func displaySomething(viewModel: Feed.Something.ViewModel)
}

class FeedViewController: UIViewController, FeedDisplayLogic {
    
    var interactor: FeedBusinessLogic?
    var router: (NSObjectProtocol & FeedRoutingLogic & FeedDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FeedInteractor()
        let presenter = FeedPresenter()
        let router = FeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        
        view.backgroundColor = .blue
        
    }
    
    // MARK: Do something
    
    func doSomething() {
        
    }
    
    func displaySomething(viewModel: Feed.Something.ViewModel) {
        
    }
}
