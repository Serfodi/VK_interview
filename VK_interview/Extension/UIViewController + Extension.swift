//
//  UIViewController + Extension.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 02.12.2024.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = {} ) {
        let alertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}
