//
//  SearchDataSours.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import UIKit

enum SearchSection {
    case history
    case color
}

struct ColorFilter: Hashable {
    var title: String
    var filter: String
    var color: UIColor
}

enum SearchSectionItem: Hashable {
    case history(String)
    case color(ColorFilter)
}

struct SearchSectionData {
    var key: SearchSection
    var values: [SearchSectionItem]
}


final class SearchDataSours: UITableViewDiffableDataSource<SearchSection, SearchSectionItem> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.reuse(UITableViewCell.self, indexPath)
            var content = cell.defaultContentConfiguration()
            switch itemIdentifier {
            case .history(let history):
                content.image = StaticImage.searchIcon
                content.text = history
            case .color(let colorItem):
                content.image = StaticImage.colorIcon?.withTintColor(colorItem.color, renderingMode: .alwaysOriginal)
                content.text = colorItem.title
                cell.accessibilityLabel = colorItem.title + " " + "Color".localized()
            }
            cell.contentConfiguration = content
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sectionIdentifier(for: section)
        return .color == section ? "Color".localized() : nil
    }
    
    func reload(_ data: [SearchSectionData], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        for item in data {
            snapshot.appendSections([item.key])
            snapshot.appendItems(item.values, toSection: item.key)
        }
        apply(snapshot, animatingDifferences: animated)
    }
    
}
