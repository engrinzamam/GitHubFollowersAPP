//doronkatz

//
//  FollowersListVC.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {

    @IBOutlet weak var collectionViewFollers: UICollectionView!
    
    //MARK:- Properties
    var followers = [Follower]()
    var filterFollowers = [Follower]()
    var username: String!
    var page: Int = 1
    var perPage = 100
    let searchController = UISearchController()
    var addButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightBarButtonItem()
        getFollowers(username: username)
        title = username
        let backButton = UIBarButtonItem()
        backButton.title = "Search"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
        configureSearchController()
        
        self.collectionViewFollers.register(UINib(nibName: FollowerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier)
        self.collectionViewFollers.dataSource = self
        self.collectionViewFollers.delegate = self
    }
    
    func configureSearchController() {
//        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search for a username"
        searchBar.tintColor = .green
        searchBar.barTintColor = .systemPink
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    func addRightBarButtonItem() {
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavourite))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addFavourite() {
        print("Right TabBar Tapped")
        NetworkManager.shared.getUserInfo(for: self.username) { result in
         
            switch result {
            case .success(let user):
                print(user)
                let favouriteFollower = FavouriteFollower(login: user.login, avatarUrl: user.avatarUrl)
                self.saveFavouriteFollower(favourite: favouriteFollower)
                
            case .failure(let err):
                self.showAlert(title: "Something went wrongg", message: err.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func saveFavouriteFollower(favourite: FavouriteFollower) {
        PersistenceManager.updateWith(favourite: favourite, actionType: .add) { error in
            guard let err = error else {
                self.showAlert(title: "Success!", message: "You have successfully favourited this user 🎉", buttonTitle: "OK")
                return
            }
            self.showAlert(title: "Something went wrong", message: err.rawValue, buttonTitle: "OK")
        }
    }
    
    func getFollowers(username: String) {
        self.addButton.isEnabled = false
        NetworkManager.shared.getFollowers(userName: username, perPage: perPage, page: page) { result in
            
            DispatchQueue.main.async {
                self.addButton.isEnabled = true
            }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                print(followers.count)
                //print(followers)
                DispatchQueue.main.async {
                    self.collectionViewFollers.reloadData()
                }
            case .failure(let error):
                self.showAlert(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
}

extension FollowersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterFollowers.count
        } else {
         return followers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier, for: indexPath) as! FollowerCollectionViewCell
        if searchController.isActive && searchController.searchBar.text != "" {
            let follower = self.filterFollowers[indexPath.row]
            cell.follower = follower
        } else {
            let follower = self.followers[indexPath.row]
            cell.follower = follower
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 28) / 3
        print(width)
        return CGSize(width: width, height: 143)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userInfoVC = storyboard?.instantiateViewController(identifier: "UserInfoVC") as! UserInfoVC
        userInfoVC.delegate = self
        if searchController.isActive && searchController.searchBar.text != "" {
            let follower = self.filterFollowers[indexPath.row]
            userInfoVC.userName = follower.login
        } else {
            let follower = self.followers[indexPath.row]
            userInfoVC.userName = follower.login
//            self.present(userInfoVC, animated: true, completion: nil)
        }
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}


extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { //, !searchText.isEmpty
            return
        }
        print(searchText)
        searchUser(searchText: searchText)
    }
}

extension FollowersListVC {
    
    func searchUser(searchText: String) {
        self.filterFollowers = followers.filter { follower in
            return follower.login!.lowercased().contains(searchText.lowercased())
        }
        collectionViewFollers.reloadData()
    }
}

extension FollowersListVC: UserFollowersDelegare {
    
    func getUserFollowers(nameUser: String) {
        print("Hello User:- \(nameUser)")
        self.followers = []
        self.filterFollowers = []
        getFollowers(username: nameUser)
        username = nameUser
        title = username
    }
}
