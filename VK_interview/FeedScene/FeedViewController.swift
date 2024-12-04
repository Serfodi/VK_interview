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
        configuration()
        setupBindings()
    }
    
    // MARK: Do something
        
    func displaySomething(viewModel: Feed.Something.ViewModel) {
        switch viewModel {
        case .displayPhotosCell(photos: let photos):
            dataSource.reload(photos)
            collectionView.isLoad.send(false)
            UIAccessibility.post(notification: .pageScrolled, argument: "New photos have been uploaded".localized())
            photos.isEmpty ? contentShowSearch() : contentHideAll()
        case .displayFooterLoader:
            collectionView.isLoad.send(true)
        case .displayAlert(header: let head, text: let text):
            self.showAlert(with: head, and: text)
        }
    }
    
    private func setupBindings() {
        searchController.searchClicked
            .sink { [weak self] query in
                self?.dataSource.reload([], animated: false)
                self?.contentShowLoading()
                self?.interactor?.doSomething(request: .search(parameters: query))
            }.store(in: &store)
        
        dataSource.isEndScroll
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] value in
                self?.interactor?.doSomething(request: .nextPage)
            }.store(in: &store)
        
        NotificationCenter.default.publisher(for: .footerButtonTapped)
            .throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] _ in
                self?.interactor?.doSomething(request: .nextPage)
            }.store(in: &store)
    }
    
    private func configuration() {
        navigationItem.title = "Search".localized()
        navigationItem.title?.isAccessibilityElement = false
        navigationItem.leftBarButtonItem = .init(image: StaticImage.store, style: .done, target: self, action: #selector(clearButton))
        navigationItem.leftBarButtonItem?.accessibilityLabel = "Delete cache".localized()
        contentShowFirst()
        #if DEBUG
        createFPS()
        #endif
    }
    
    @objc func clearButton() {
        self.interactor?.doSomething(request: .clearStore)
    }
    
}

#if DEBUG
extension FeedViewController {
    func createFPS() {
        let fpsView = FPSView(frame: .zero)
        self.view.addSubview(fpsView)
        fpsView.translatesAutoresizingMaskIntoConstraints = false
        fpsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        fpsView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        fpsView.startFPS()
    }
}
#endif
