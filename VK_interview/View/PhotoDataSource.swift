//
//  PhotoDataSource.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

enum Section: Hashable {
    case main
}

final class PhotoDataSource: UICollectionViewDiffableDataSource<Section, PhotoDisplayCell> {
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.reuse(PhotoViewCell.self, with: itemIdentifier, indexPath)
        }
    }
    
    func reload(_ data: [PhotoDisplayCell], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoDisplayCell>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        self.apply(snapshot, animatingDifferences: animated)
    }
    
}

extension PhotoDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let sectionId = sectionIdentifier(for: indexPath.section) else { return .zero }
        switch sectionId {
        case .main:
            guard let model = itemIdentifier(for: indexPath) else { return .zero }
            return model.size.totalSize
        }
    }
    
}
