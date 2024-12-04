//
//  UIViewController + Extension.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, and message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}

extension UIViewController {
    
    func contentHideAll() {
        guard #available(iOS 17.0, *) else { return }
        contentUnavailableConfiguration = nil
    }
    
    func contentShowFirst() {
        guard #available(iOS 17.0, *) else { return }
        var firstConfig = UIContentUnavailableConfiguration.empty()
        firstConfig.image = StaticImage.imageStar
        firstConfig.text = "Start the search".localized()
        firstConfig.secondaryText = "Look for photos and get inspired".localized()
        contentUnavailableConfiguration = firstConfig
    }
    
    func contentShowSearch() {
        guard #available(iOS 17.0, *) else { return }
        contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
    }
    
    func contentShowLoading() {
        guard #available(iOS 17.0, *) else { return }
        var config = UIContentUnavailableConfiguration.loading()
        config.text = "Download".localized()
        contentUnavailableConfiguration = config
    }
    
}
