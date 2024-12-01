//
//  UILabel + Extension.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

extension UILabel {
    
    convenience init(title: String?,
                     accessibleText: String? = nil,
                     fount: UIFont = FontAppearance.body,
                     alignment: NSTextAlignment = .left,
                     color: UIColor = ColorAppearance.black) {
        self.init()
        self.text = title
        self.accessibilityLabel = accessibleText
        self.font = fount
        self.textColor = color
        self.textAlignment = alignment
    }
 
}

extension UILabel {
    
    func sizeText() -> CGSize {
        guard let text = text else { return .zero }
        return text.size(withAttributes: [.font : self.font!])
    }
 
}
