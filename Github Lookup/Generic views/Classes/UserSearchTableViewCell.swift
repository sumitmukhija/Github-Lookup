//
//  UserSearchTableViewCell.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit
import UICountingLabel

class UserSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNumberOfRepos: UICountingLabel!
    @IBOutlet weak var lblNumberOfFollowing: UICountingLabel!
    @IBOutlet weak var lblLastUpdated: UILabel!
    @IBOutlet weak var lblNumberOfGists: UICountingLabel!
    @IBOutlet weak var lblNumberOfFollowers: UICountingLabel!
    @IBOutlet weak var lblGitUsername: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    override func awakeFromNib() {
        self.imgAvatar.layer.masksToBounds = true
        self.imgAvatar.layer.cornerRadius = 30.0
    }
}
