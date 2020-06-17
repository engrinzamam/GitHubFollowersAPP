//
//  UIViewController+Ext.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
            alertVC.titleAlert = title
            alertVC.message = message
            alertVC.buttonTitle = buttonTitle
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor  = .systemGreen
        present(safariVC, animated: true)
    }
}
