//
//  PhotoCell.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class PhotoViewCell: UICollectionViewCell, SelfConfiguringCell {
    
    var photoDisplay: PhotoDisplay?
    
    let photoImageView = UIImageView(image: nil)
    let descriptionLabel = UILabel()
    let profileView = ProfileView()
    let likeLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .center)
    let dataLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .center)
    
    // MARK: Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        configuration()
        configurationFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let photoDisplay: PhotoDisplay = value as? PhotoDisplay else { return }
        self.photoDisplay = photoDisplay
        
        photoImageView.image = nil
        descriptionLabel.text = photoDisplay.description
        
        photoImageView.frame = photoDisplay.size.imageViewFrame
        descriptionLabel.frame = photoDisplay.size.descriptionLabelFrame
    }
    
}

private extension PhotoViewCell {
    
    func configuration() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 13
        descriptionLabel.numberOfLines = 0
        photoImageView.backgroundColor = ColorAppearance.lightGray
    }
    
    private func configurationFrame() {
        addSubview(descriptionLabel)
        addSubview(photoImageView)
    }
    
}
