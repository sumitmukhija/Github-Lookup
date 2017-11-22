//
//  FollowListViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class FollowListCell: UITableViewCell
{
    @IBOutlet weak var imgFollow: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        imgFollow.layer.cornerRadius = 40.0
        imgFollow.layer.masksToBounds = true
    }
}

class FollowListViewController: BaseTabViewController, UITableViewDelegate, UITableViewDataSource {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    @IBOutlet weak var followTableView: UITableView!
    
    var dataSource: Array<User>?
    var operationMode: OPMODE? = .FOLLOWING
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        title = (operationMode == OPMODE.FOLLOWING) ? ("Following") : ("Followers")
        followTableView.separatorStyle = .none
        followTableView.showsVerticalScrollIndicator = false
        followTableView.delegate = self
        followTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if operationMode == OPMODE.FOLLOWING
        {
            Utility.showInfoAlert(msg: "The feature is not supported by the API yet!")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.FOLLOW_CELL_ID) as! FollowListCell
        let activeUser = dataSource?[indexPath.row]
        cell.lblName.text = activeUser?.login!
        
        if let cachedImage = imageCache.object(forKey: NSString(string: (activeUser?.login!)!)) {
            cell.imgFollow.image = cachedImage
        }
        else
        {
            if activeUser?.avatarUrl != GEN_STRINGS.NO_URL
            {
                DispatchQueue.global(qos: .background).async {
                    let url = URL(string:(activeUser?.avatarUrl)!)
                    let data = try? Data(contentsOf: url!)
                    let image: UIImage = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: NSString(string: (activeUser?.login!)!))
                        cell.imgFollow.image = image
                    }
                }
            }
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let activeUser = dataSource?[indexPath.row]
        if let url = activeUser?.htmlUrl
        {
            UIApplication.shared.openURL(URL(string: url)!)
        }
        else
        {
            Utility.showErrorAlert(msg: GEN_STRINGS.CANT_VISIT)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = dataSource
        {
            return dataSource!.count
        }
        return 0
    }
}
