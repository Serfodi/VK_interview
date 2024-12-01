//
//  FeedViewController.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

protocol FeedDisplayLogic: AnyObject {
    @MainActor func displaySomething(viewModel: Feed.Something.ViewModel)
}

class FeedViewController: UIViewController, FeedDisplayLogic {
    
    var interactor: FeedBusinessLogic?
    var router: (NSObjectProtocol & FeedRoutingLogic & FeedDataPassing)?
    
    let collectionView: PhotoCollectionView
    let dataSource : PhotoDataSource
    
    // MARK: Object lifecycle
    
    init() {
        self.collectionView = .init()
        self.dataSource = .init(collectionView)
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
//        router.dataStore = interactor
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
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        collectionView.edgesToSuperView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PhotoViewCell.self)
        collectionView.delegate = dataSource
        doSomething()
    }
    
    // MARK: Do something
    
    func doSomething() {
        let query = ConfigurationQuery(query: "cat")
        interactor?.doSomething(request: .search(parameters: query))
    }
    
    func displaySomething(viewModel: Feed.Something.ViewModel) {
        switch viewModel {
        case .displayPhotosCell(photos: let photos):
            dataSource.reload(photos)
        case .displayError(error: let error):
            print(error)
        }
    }
    
}
