//
//  UICollectionView + Extension.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

protocol SelfConfiguringCell : UICollectionViewCell {
    func configure<U: Hashable>(with value: U)
}

extension UICollectionViewCell {
        
    static var reuseIdentifier: String {
        String(describing: self)
    }

    var identifier: String {
        type(of: self).reuseIdentifier
    }
}


extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
        
    func reuse<T: SelfConfiguringCell, U: Hashable>(_ type: T.Type, with value: U, _ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to dequeue \(type)") }
        cell.configure(with: value)
        return cell
    }
}
