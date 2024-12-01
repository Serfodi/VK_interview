//
//  PhotoCollectionView.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class PhotoCollectionView: UICollectionView {
    
    // MARK: init
        
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: StaticCellSize.padding, bottom: 0, right: StaticCellSize.padding)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: layout)
        configuration()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: Configuration
    
    private func configuration() {
        allowsMultipleSelection = false
    }
}
