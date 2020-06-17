//
//  Utilities.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 15/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    class func getFormattedDateString(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:stringDate)!
        
        let dateFormatterOutPut = DateFormatter()
        dateFormatterOutPut.dateFormat = "MMM yyyy"
        let stringDate = dateFormatterOutPut.string(from: date)
        print("Date is  \(stringDate)")
        return stringDate
    }
    
    class func getActivityIndicator(style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let indictaor = UIActivityIndicatorView(style: style)
        indictaor.startAnimating()
        indictaor.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        return indictaor
    }
}

enum Images {
                
    static let ghLogo                   = UIImage(named: "gh-logo")
    static let placeHolder              = UIImage(named: "avatar-placeholder")
    static let emptyState               = UIImage(named: "empty-state-logo")
}
