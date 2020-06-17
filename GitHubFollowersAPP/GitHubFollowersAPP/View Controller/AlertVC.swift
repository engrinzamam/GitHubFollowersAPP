//
//  AlertVC.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var messageText: UILabel!
    
    var titleAlert: String?
    var message: String?
    var buttonTitle: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.alertView.layer.cornerRadius = 16
        self.alertView.layer.borderWidth = 2
        self.alertView.layer.borderColor = UIColor.white.cgColor
        self.titleBtn.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleText.text = titleAlert
        self.messageText.text = message
        self.titleBtn.titleLabel?.text = buttonTitle
        configureViewController()
    }
    
   
    @IBAction func buttonAlertTapped(_ sender: UIButton) {
        self.dismissAlert()
    }
    
    func configureViewController() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        let label = UILabel()
        label.text = "Hello Hello"
        label.frame = view.frame
        label.textAlignment = .center
//        self.view.addSubview(label)
    }
    
    func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }

}
