//
//  NSLayoutConstraint + Extension.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

extension UIView {
    
    func edgesToSuperView(value: CGFloat = 0) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: value),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -value),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: value),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -value)
        ])
    }
    
}
