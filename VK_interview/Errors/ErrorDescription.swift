//
//  ErrorDescription.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

enum ErrorDescription: Error, LocalizedError {
    case description(String)
    
    var errorDescription: String? {
        switch self {
        case .description(let text):
            return "Error: \(text)"
        }
    }
}
