//
//  PhotoDataSource.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit
import Combine

enum Section: Hashable {
    case main
}

final class PhotoDataSource: UICollectionViewDiffableDataSource<Section, PhotoDisplayCell> {
    
    let isEndScroll = PassthroughSubject<Bool, Never>()
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.reuse(PhotoViewCell.self, with: itemIdentifier, indexPath)
        }
    }
    
    func registerFooter(_ view: UICollectionView.SupplementaryRegistration<LoadIndicatorView>) {
        supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            collectionView.dequeueConfiguredReusableSupplementary(using: view, for: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: 50, height: 50)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if (offsetY) > (contentHeight - height) {
            isEndScroll.send(true)
        }
    }
    
}
