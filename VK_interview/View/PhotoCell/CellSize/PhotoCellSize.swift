//
//  PhotoCellSize.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit


/// Calculates cell sizes based on dynamic content
protocol PhotoCellLayoutCalculateProtocol {
    func sizes(description: String?, photo: CGSize) -> PhotoCellSize
}

final class CalculateCellSize: PhotoCellLayoutCalculateProtocol {
    
    struct Sizes: PhotoCellSize {
        var imageViewFrame: CGRect
        var descriptionLabelFrame: CGRect
        var viewInfo: CGRect
        var profileViewFrame: CGRect
        var totalSize: CGSize
    }
    
    func sizes(description: String?, photo: CGSize) -> any PhotoCellSize {
        let width = floor(UIScreen.main.bounds.width - StaticCellSize.padding * 2)
        
        // imageViewFrame
        let ration: CGFloat = CGFloat( Float(photo.height) / Float(photo.width) )
        let height = width * ration
        let photoSize = CGSize(width: width, height: height)
        let photoFrame = CGRect(origin: .zero, size: photoSize)
        
        // descriptionLabelFrame
        var descriptionFrame = CGRect.zero
        if let text = description, !text.isEmpty {
            let height = text.height(width: width)
            descriptionFrame.size = CGSize(width: width, height: height)
            descriptionFrame.origin = CGPoint(x: 0, y: photoFrame.maxY + StaticCellSize.padding2)
        }
        
        let viewInfoFrame = CGRect(x: 0, y: max(descriptionFrame.maxY, photoFrame.maxY), width: width, height: StaticCellSize.infoHight)
        let profileViewFrame = CGRect(x: 0, y: viewInfoFrame.maxY + StaticCellSize.padding2, width: width, height: StaticCellSize.profileImageHight)
        
        let totalHeight = profileViewFrame.maxY
        
        return Sizes(imageViewFrame: photoFrame,
                     descriptionLabelFrame: descriptionFrame,
                     viewInfo: viewInfoFrame,
                     profileViewFrame: profileViewFrame,
                     totalSize: CGSize(width: width, height: totalHeight))
    }
}
