//
//  ConfigurationQuery.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

public struct ConfigurationQuery {
    let query: String
    let color: String?
    var page: Int
    let perPage = 30
    
    init(query: String, color: String? = nil, page: Int = 1) {
        self.query = query
        self.page = page
        self.color = color
    }
        
    private var search: String {
        let trimmedString = query.trimmingCharacters(in: .whitespaces)
        let replacedString = trimmedString.replacingOccurrences(of: " ", with: "+")
        return replacedString
    }
    
    var requestParameters: [String:String] {
        var parameters = ["query" : search]
        parameters["page"] = String(page)
        parameters["per_page"] = String(perPage)
        if let color = color { parameters["color"] = color }
        return parameters
    }
    
}
