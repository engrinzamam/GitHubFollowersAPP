//
//  Date+Ext.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 15/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getFormattedDateString(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:stringDate)!
        
        let dateFormatterOutPut = DateFormatter()
        dateFormatterOutPut.dateFormat = "MM yyy"
        let stringDate = dateFormatterOutPut.string(from: date)
        print("Date is  \(stringDate)")
        return stringDate
    }
    
}
