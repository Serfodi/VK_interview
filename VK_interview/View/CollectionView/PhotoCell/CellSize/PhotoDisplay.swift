//
//  PhotoDisplay.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation


protocol PhotoCellSize {
    var imageViewFrame: CGRect { get }
    var descriptionLabelFrame: CGRect { get }
    var viewInfoFrame: CGRect { get }
    var profileViewFrame: CGRect { get }
    var totalSize: CGSize { get }
}


protocol PhotoDisplay {
    var imageURL: String { get }
    var description: String? { get }
    var size: PhotoCellSize { get }
    var date: Date { get }
    var like: Int { get }
    var userImage: String { get }
    var userName: String { get }
}


struct PhotoDisplayCell: PhotoDisplay {
    var id: String
    var imageURL: String
    var description: String?
    var userImage: String
    var userName: String
    var size: PhotoCellSize
    var date: Date
    var like: Int
}


extension PhotoDisplayCell: Hashable {
    
    static func == (lhs: PhotoDisplayCell, rhs: PhotoDisplayCell) -> Bool {
        lhs.size.totalSize == rhs.size.totalSize && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
