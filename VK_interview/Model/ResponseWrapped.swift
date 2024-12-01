//
//  ResponseWrapped.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

struct ResponseWrapped<T: Decodable>: Decodable {
    let results: [T]
}
