//
//  FavouriteTableViewCell.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 16/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    
    var favouriteFollower: FavouriteFollower! {
        didSet {
            DispatchQueue.main.async {
                self.userName.text = self.favouriteFollower.login
                NetworkManager.shared.downloadImage(from: self.favouriteFollower.avatarUrl!) { image in
                    DispatchQueue.main.async {
                        self.imageUser.layer.cornerRadius = 10
                        self.imageUser.clipsToBounds = true
                        self.imageUser.image = image
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
