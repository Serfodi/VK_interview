//
//  SearchViewController.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import UIKit
import Combine


final class SearchViewController: UISearchController {

    let searchClicked = PassthroughSubject<ConfigurationQuery, Never>()
    private var store = Set<AnyCancellable>()
    
    private let searchTable: SearchTableViewController
    
    // MARK: Object lifecycle
    
    init() {
        searchTable = SearchTableViewController()
        super.init(searchResultsController: searchTable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchResultsUpdater = self
        hidesNavigationBarDuringPresentation = false
        obscuresBackgroundDuringPresentation = false
        scopeBarActivation = .manual
        setupBindings()
    }
    
    // MARK: Helpers
    
    private func searchToken(_ tokenValue: ColorFilter) -> UISearchToken {
        let image = StaticImage.colorIcon?.withTintColor(tokenValue.color, renderingMode: .alwaysOriginal)
        let searchToken = UISearchToken(icon: image, text: tokenValue.title.localized())
        searchToken.representedObject = tokenValue.filter
        return searchToken
    }
    
    private func getToken() -> String? {
        searchBar.searchTextField.tokens.first?.representedObject as? String
    }
    
    func setupBindings() {
        searchTable.selectedHistorySubject.sink { [weak self] model in
            self?.searchBar.text = model
        }.store(in: &store)
        
        searchTable.selectedColorSubject.sink { [weak self] model in
            guard let self else { return }
            self.searchBar.searchTextField.tokens = [self.searchToken(model)]
        }.store(in: &store)
    }
    
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showsSearchResultsController = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTable.reload(with: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        showsSearchResultsController = false
        
        let parameters = ConfigurationQuery(query: text, color: getToken())
        searchClicked.send(parameters)
        
        self.isActive = false
        
        searchTable.addItemHistory(text: text)
        searchTable.reload()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showsSearchResultsController = false
    }
}

// MARK: UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.showsSearchResultsController = searchController.isActive
    }
        
}
