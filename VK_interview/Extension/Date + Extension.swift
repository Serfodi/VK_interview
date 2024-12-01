//
//  Date + Extension.swift
//  VK_interview
//
//  Created by Сергей Насыбуллин on 01.12.2024.
//

import Foundation

extension Date {
    
    func compareDay(_ other: Date) -> Bool {
        let selfComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let otherComponents = Calendar.current.dateComponents([.year, .month, .day], from: other)
        return selfComponents.day == otherComponents.day
    }
    
    func formateDate() -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let componentsDifference = calendar.dateComponents([.year, .month, .day, .hour], from: self, to: Date())
        
        if componentsDifference.year! > 0 {
            dateFormatter.dateFormat = "d MMM yyyy"
            return dateFormatter.string(from: self)
        } else if componentsDifference.day! > 0 {
            dateFormatter.dateFormat = "d MMM"
            return dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "HH:mm"
            let date = dateFormatter.string(from: self)
            if !self.compareDay(Date()) {
                return "\("Уesterday".localized()) \(date))"
            }
            return "\("Today".localized()) \(date))"
        }
    }
}
