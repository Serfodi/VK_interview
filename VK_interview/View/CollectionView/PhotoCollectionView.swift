//
//  PhotoCollectionView.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit
import Combine

class PhotoCollectionView: UICollectionView {
    
    let isLoad = PassthroughSubject<Bool, Never>()
    private var store: Set<AnyCancellable> = []
    
    // MARK: init
        
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: StaticCellSize.padding, bottom: 0, right: StaticCellSize.padding)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: layout)
        configuration()
    }
    
    public func createRefreshControl() -> SupplementaryRegistration<LoadIndicatorView> {
        UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionFooter) { supplementaryView, elementKind, indexPath in
            self.isLoad.sink { value in
                supplementaryView.isLoad(value)
            }.store(in: &self.store)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: Configuration
    
    private func configuration() {
        allowsMultipleSelection = false
    }
    
}

