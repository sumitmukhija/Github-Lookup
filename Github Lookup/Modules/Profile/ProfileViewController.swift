//
//  ProfileViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTabViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var user: User?
    var userImage: UIImage?
    
    var stats: [[String: Int]]?
    var colors = [COLORS.MAT_CYAN, COLORS.MAT_TEAL, COLORS.MAT_AMBER,  COLORS.MAT_GREEN]
    
    @IBOutlet weak var lblWorkplace: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet weak var lblBio: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn()
        if let _ = user
        {
            self.title = "\(self.user!.login!)'s Profile"
            let nib = UINib(nibName: FILE_NAMES.TILE_COLLECTION_CELL , bundle: nil)
            statsCollectionView.register(nib, forCellWithReuseIdentifier: IDENTIFIERS.TILE_COLLECTION_CELL)
            statsCollectionView.delegate = self
            statsCollectionView.dataSource = self
            initView()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func initView()
    {
        if let _ = userImage
        {
            imgProfile.image = userImage!
        }
        else
        {
            //this case would never happen though, still fallback
            imgProfile.image = #imageLiteral(resourceName: "img_male_avatar")
        }
        lblWorkplace.text = user!.company!
        lblBio.text  = user!.bio!
        lblCity.text = user!.location!
        stats = [["Public repos": user!.publicRepos!], ["Followers": user!.followers], ["Following": user!.following], ["Public gists": user!.publicGists]]
        statsCollectionView.showsVerticalScrollIndicator = false
        statsCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func viewFollowingAction(_ sender: AnyObject) {
        navigateToFollowScreen(opMode: .FOLLOWING)
    }
    @IBAction func viewFollowersAction(_ sender: AnyObject) {
        navigateToFollowScreen(opMode: .FOLLOWERS)
    }
    
    
    @IBAction func visitAction(_ sender: AnyObject) {
        if let url = user?.htmlUrl
        {
            UIApplication.shared.openURL(URL(string: url)!)
        }
        else
        {
            Utility.showErrorAlert(msg: GEN_STRINGS.CANT_VISIT)
        }
    }
    
    func navigateToFollowScreen(opMode: OPMODE)
    {
        if(opMode == .FOLLOWERS)
        {
            showHUD()
            ServerManager.getUserFollowers(url: user!.followersUrl, completion: { (error, user) in
                super.hideHUD()
                let followListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: IDENTIFIERS.FOLLOW_LIST_VC_ID) as! FollowListViewController
                followListViewController.operationMode = opMode
                if let _ = user
                {
                    followListViewController.dataSource = user
                    self.navigationController?.pushViewController(followListViewController, animated: true)
                }
                else{
                    if let _ = error
                    {
                        Utility.showErrorAlert(code: error!.code)
                    }
                }
            })
        }
        else
        {
            let followListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: IDENTIFIERS.FOLLOW_LIST_VC_ID) as! FollowListViewController
            followListViewController.operationMode = opMode
            self.navigationController?.pushViewController(followListViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS.TILE_COLLECTION_CELL, for: indexPath) as! TileCollectionViewCell
        cell.wrapperView.layer.cornerRadius = 6.0
        cell.wrapperView.backgroundColor = colors[indexPath.row]
        if let dictionary = stats?[indexPath.row]
        {
            cell.lblText.text = dictionary.keys.first!
            cell.lblNumber.text = "\(dictionary.values.first!)"
        }
        
        return cell
    }
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 60)
    }
}
