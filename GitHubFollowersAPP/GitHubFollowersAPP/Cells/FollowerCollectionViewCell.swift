//
//  FollowerCollectionViewCell.swift
//  GitHubFollowersAPP
//
//  Created by Sixlogics on 12/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var follower: Follower! {
        didSet {
            DispatchQueue.main.async {
                self.userName.text = self.follower.login
                NetworkManager.shared.downloadImage(from: self.follower.avatarUrl!) { image in
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
    }

}
