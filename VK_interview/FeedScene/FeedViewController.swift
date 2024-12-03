//
//  FeedViewController.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit
import Combine

protocol FeedDisplayLogic: AnyObject {
    @MainActor func displaySomething(viewModel: Feed.Something.ViewModel)
}

class FeedViewController: UIViewController, FeedDisplayLogic {
    
    var interactor: FeedBusinessLogic?
    
    let collectionView: PhotoCollectionView
    let dataSource : PhotoDataSource
    let searchController: SearchViewController
    
    private var store: Set<AnyCancellable> = []
    
    // MARK: Object lifecycle
    
    init() {
        self.collectionView = .init()
        self.dataSource = .init(collectionView)
        self.searchController = .init()
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
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
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
        dataSource.registerFooter(collectionView.createRefreshControl())
        navigationItem.searchController = searchController
        navigationItem.title = "Search".localized()
        setupBindings()
    }
    
    // MARK: Do something
        
    var start = Date()
    
    func displaySomething(viewModel: Feed.Something.ViewModel) {
        switch viewModel {
        case .displayPhotosCell(photos: let photos):
            print(Date().timeIntervalSince(start))
            dataSource.reload(photos)
            collectionView.isLoad.send(false)
        case .displayFooterLoader:
            collectionView.isLoad.send(true)
        case .displayError(error: let error):
            self.showAlert(with: "Error".localized(), and: error)
            print(error)
        }
    }
    
    func setupBindings() {
        dataSource.isEndScroll
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] value in
                self?.interactor?.doSomething(request: .nextPage)
            }.store(in: &store)
        
        searchController.searchClicked.sink { [weak self] query in
            self?.start = Date()
            self?.interactor?.doSomething(request: .search(parameters: query))
        }.store(in: &store)
    }
    
}
