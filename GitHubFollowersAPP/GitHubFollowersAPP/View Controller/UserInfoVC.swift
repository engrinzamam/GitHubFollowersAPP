//
//  UserInfoVC.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 13/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

//For ScrollView
//https://www.freecodecamp.org/news/how-to-use-auto-layout-with-uiscrollview-for-ios-b94b8687a4cc/

import UIKit

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var gitgubProfileBtn: UIButton!
    @IBOutlet weak var getFollowersBtn: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var publicReposLabel: UILabel!
    @IBOutlet weak var publicGistsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var userName: String!
    var delegate: UserFollowersDelegare?
    var currentUser: User!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewOne.layer.cornerRadius = 10
        self.viewTwo.layer.cornerRadius = 10
        self.gitgubProfileBtn.layer.cornerRadius = 10
        self.getFollowersBtn.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userName
        self.getUserDetails(userName: userName)
    }
    
    func getUserDetails(userName: String) {
        print("Get User Details")
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.startAnimating()
        
        self.view.addSubview(activityView)
        
        NetworkManager.shared.getUserInfo(for: userName) { result in
            DispatchQueue.main.async {
                activityView.stopAnimating()
            }
            switch result {
            case .success(let user):
                self.currentUser = user
                DispatchQueue.main.async {
                    NetworkManager.shared.downloadImage(from: user.avatarUrl!) { image in
                        DispatchQueue.main.async {
                            self.avatarImageView.layer.cornerRadius = 10
                            self.avatarImageView.clipsToBounds = true
                            self.avatarImageView.image = image
                        }
                    }
                    self.usernameLabel.text = user.login
                    self.nameLabel.text = user.name
                    self.locationLabel.text = user.location ?? "No Location"
                    self.bioLabel.text = user.bio ?? "No Bio Available"
                    
                    self.publicReposLabel.text = "\(user.publicRepos ?? -1)"
                    self.publicGistsLabel.text = "\(user.publicGists ?? -1)"
                    self.followersLabel.text = "\(user.followers ?? -1)"
                    self.followingLabel.text = "\(user.following ?? -1)"
                    if let date = user.createdAt {
                        let stringDate = Utilities.getFormattedDateString(stringDate: date)
                        self.createdAtLabel.text = "GitHub since \(stringDate)"
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @IBAction func actionGithubProfileTapped(_ sender: UIButton) {
        if let htmlURL = currentUser.htmlUrl, let url = URL(string: htmlURL) {
            self.presentSafariVC(with: url)
        }
    }
    
    @IBAction func actionGetFollowersTapped(_ sender: UIButton) {
        self.delegate?.getUserFollowers(nameUser: self.userName)
        self.navigationController?.popViewController(animated: true)
    }
}

protocol UserFollowersDelegare {
    func getUserFollowers(nameUser: String)
}
