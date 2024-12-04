//
//  LoadIndicatorView.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import UIKit

class LoadIndicatorView: UICollectionReusableView {
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private lazy var nextPageButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.image = StaticImage.arrow
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        button.accessibilityLabel = "Load next page".localized()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let isVoiceOverRunning = UIAccessibility.isVoiceOverRunning
        
        if isVoiceOverRunning {
            self.addSubview(nextPageButton)
            nextPageButton.edgesToSuperView(value: 10)
            nextPageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        } else {
            self.addSubview(loaderView)
            loaderView.edgesToSuperView()
        }
    }
    
    func isLoad(_ value: Bool) {
        if value {
            loaderView.startAnimating()
        } else {
            loaderView.stopAnimating()
        }
    }
    
    @objc private func buttonTapped() {
        NotificationCenter.default.post(name: .footerButtonTapped, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Notification.Name {
    static let footerButtonTapped = Notification.Name("footerButtonTapped")
}
