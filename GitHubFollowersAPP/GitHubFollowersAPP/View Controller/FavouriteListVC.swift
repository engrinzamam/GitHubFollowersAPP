//
//  FavouriteListVC.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class FavouriteListVC: UIViewController {

    @IBOutlet weak var tableViewFavourite: UITableView!
    var favouriteFollowers:[FavouriteFollower] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavouriteFollowers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Favourite"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableViewFavourite.delegate = self
        self.tableViewFavourite.dataSource = self
    }
    
    func getFavouriteFollowers() {
        guard let favouriteData = UserDefaults.standard.object(forKey: Keys.favourites) as? Data else {
//            self.showAlert(title: "Bad Stuff Happened", message: "Something Worng Happened", buttonTitle: "OK")
            print("Followers Not Found Error")
            DispatchQueue.main.async {
                self.tableViewFavourite.reloadData()
            }
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let favouriteList = try decoder.decode([FavouriteFollower].self, from: favouriteData)
            self.favouriteFollowers = favouriteList
            DispatchQueue.main.async {
                self.tableViewFavourite.reloadData()
            }
        } catch (let err) {
            print(err.localizedDescription)
        }
    }
    
    func showTableVIewBackgroundView() {
        let message = "No favourites?\nGo follow a user from follower screen 😀"
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableViewFavourite.bounds.size.width, height: tableViewFavourite.bounds.size.height))
        noDataLabel.text          = message
        noDataLabel.numberOfLines = 0
        noDataLabel.textColor     = .secondaryLabel
        noDataLabel.textAlignment = .center
        noDataLabel.font = .systemFont(ofSize: 23, weight: .semibold)
        
        let logoImageView   = UIImageView()
        logoImageView.frame = CGRect(x: 0, y: 0, width: tableViewFavourite.bounds.size.width, height: 200)
        logoImageView.image                     = Images.emptyState
        logoImageView.addSubview(noDataLabel)
        tableViewFavourite.backgroundView = logoImageView
    }
}

extension FavouriteListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favouriteFollowers.isEmpty {
            showTableVIewBackgroundView()
        } else {
            tableViewFavourite.backgroundView = nil
        }
        return favouriteFollowers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as? FavouriteTableViewCell {
            let favouriteFillower = self.favouriteFollowers[indexPath.row]
            cell.favouriteFollower = favouriteFillower
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "FollowersListVC") as! FollowersListVC
        let favouriteFillower = self.favouriteFollowers[indexPath.row]
        vc.username = favouriteFillower.login
        self.navigationController?.pushViewController(vc, animated: true)
        tableViewFavourite.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            PersistenceManager.updateWith(favourite: self.favouriteFollowers[indexPath.row], actionType: .remove) { error in
                guard let err = error else {
                    self.favouriteFollowers.remove(at: indexPath.row)
                    self.tableViewFavourite.deleteRows(at: [indexPath], with: .automatic)
                    return
                }
                self.showAlert(title: "Not Delete", message: "\(err.rawValue) - Something wrong with remove to Favourite Follower", buttonTitle: "OK")
            }
        }
    }
}
