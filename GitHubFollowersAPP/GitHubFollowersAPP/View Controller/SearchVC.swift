//
//  SearchVC.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var getFollowersBtn: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameTextField.text = ""
        self.usernameTextField.layer.cornerRadius = 10
        self.usernameTextField.layer.borderWidth = 2
        self.usernameTextField.layer.borderColor = UIColor.systemGray4.cgColor
            
        self.getFollowersBtn.layer.cornerRadius = 10
        self.getFollowersBtn.backgroundColor = .systemGreen
        self.getFollowersBtn.setTitleColor(.white, for: .normal)
        self.getFollowersBtn.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getFollowersTappedAction(_ sender: UIButton) {
        guard let userName = usernameTextField.text?.trimmingCharacters(in: .whitespaces), !userName.isEmpty else {
            showAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        usernameTextField.resignFirstResponder()
        pushFollwersViewController(userName: userName)
    }
    

    func pushFollwersViewController(userName: String) {
        let vc = storyboard?.instantiateViewController(identifier: "FollowersListVC") as! FollowersListVC
        vc.username = userName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let userName = textField.text?.trimmingCharacters(in: .whitespaces), !userName.isEmpty else {
            showAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            print("Enter User Name First")
            return false
        }
        print("User Name:---- \(userName)")
        usernameTextField.resignFirstResponder()
        pushFollwersViewController(userName: userName)
        return true
    }
}
