//
//  DataError.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

enum DataError: Error, LocalizedError {
    case notData
    
    var errorDescription: String? {
        switch self {
        case .notData:
            return "Data is nil"
        }
    }
}
