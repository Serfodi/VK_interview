//
//  PhotoCell.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class PhotoViewCell: UICollectionViewCell, SelfConfiguringCell {
    
    var photoDisplay: PhotoDisplay?
    
    let photoImageView = WebImageView()
    let profileImageView = WebImageView()
    let descriptionLabel = UILabel(title: nil)
    let likeLabel = UILabel(title: "foo", fount: FontAppearance.mini, alignment: .left)
    let dataLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .right)
    let nameLabel = UILabel(title: "bee")
    private var profileStack: UIStackView!
    private var infoStack: UIStackView!
    
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
        
        // image
        photoImageView.image = nil
        profileImageView.image = nil
        if let url = URL(string: photoDisplay.imageURL) {
            photoImageView.asyncSetImage(url: url)
        }
        if let url = URL(string: photoDisplay.user.profileImage.small) {
            profileImageView.asyncSetImage(url: url)
        }
        
        // text
        descriptionLabel.text = photoDisplay.description
        likeLabel.text = "👍 \(photoDisplay.like)"
        dataLabel.text = photoDisplay.date.formateDate()
        nameLabel.text = photoDisplay.user.username
        
        // frame
        photoImageView.frame = photoDisplay.size.imageViewFrame
        descriptionLabel.frame = photoDisplay.size.descriptionLabelFrame
        infoStack.frame = photoDisplay.size.viewInfoFrame
        profileStack.frame = photoDisplay.size.profileViewFrame
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.cancelDownload()
        profileImageView.cancelDownload()
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
    
    func configurationFrame() {
        addSubview(descriptionLabel)
        addSubview(photoImageView)
        configurationStackView()
        configurationImageProfile()
        addSubview(profileStack)
        addSubview(infoStack)
    }
    
    func configurationStackView() {
        infoStack = UIStackView(arrangedSubviews: [likeLabel,dataLabel], axis: .horizontal, spacing: 5)
        profileStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel], axis: .horizontal, spacing: 5)
        profileStack.alignment = .leading
    }
    
    func configurationImageProfile() {
        profileImageView.layer.cornerRadius = StaticCellSize.profileImageHight / 2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = ColorAppearance.lightGray
        profileImageView.frame.size = CGSize(width: StaticCellSize.profileImageHight, height: StaticCellSize.profileImageHight)
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
    }
    
}
