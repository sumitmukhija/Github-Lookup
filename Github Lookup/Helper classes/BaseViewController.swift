//
//  BaseViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseTabViewController: UIViewController {
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLORS.APP_BACKGROUND
        setTabAttribs()
        setNavAttribs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideTabTitle()
    }
    
    func setTabAttribs(){
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = COLORS.APP_BACKGROUND
        self.tabBarController?.tabBar.tintColor = COLORS.GIT_BLACK
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    func hideTabTitle()
    {
        self.tabBarController?.tabBar.items?.forEach {
            $0.title = " "
            $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    func setNavAttribs()
    {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = COLORS.GIT_BLACK
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func hideNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setBackBtn()
    {
        let backImg = UIImage(named: "back")
        let backButton = UIButton(type: .custom)
        backButton.bounds = CGRect(x: 0, y: 0, width: 24.0, height: 24.0)
        backButton.setImage(backImg, for: .normal)
        backButton.addTarget(self, action: #selector(backBtnPressed(sender:)), for: .touchUpInside)
        backButton.clipsToBounds = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func share(message: String) {
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func showHUD(txt: String? = "Fetching content from GitHub")
    {
        if let _ = hud
        {
            hud!.textLabel.text = txt!
            hud!.show(in: self.view)
        }
    }
    
    func hideHUD()
    {
        if let _ = hud
        {
            hud!.dismiss(afterDelay: 0.1)
        }
    }
    
    func configureCell(activeUser: User, cell: UserSearchTableViewCell, isLocalSearch: Bool? = false)
    {
        cell.lblName.text = activeUser.name
        cell.lblCity.text = activeUser.location
        cell.lblEmail.text = activeUser.email
        cell.lblGitUsername.text = activeUser.login
        cell.lblOrganization.text = activeUser.company
        if activeUser.updatedAt! != ""
        {
            cell.lblLastUpdated.text = "Last activity: \(Utility.beautifyServerDateString(dateString: activeUser.updatedAt!))"
        }
        if activeUser.avatarUrl != GEN_STRINGS.NO_URL && isLocalSearch == false
        {
            let url = URL(string:activeUser.avatarUrl)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            cell.imgAvatar.image = image
        }
        else{
            if let _ = cell.imgAvatar
            {
                cell.imgAvatar.removeFromSuperview()
            }
        }
        
        if(isLocalSearch! == false)
        {
            cell.lblNumberOfRepos.format = "%d"
            cell.lblNumberOfFollowers.format = "%d"
            cell.lblNumberOfGists.format = "%d"
            cell.lblNumberOfFollowing.format = "%d"
            cell.lblNumberOfRepos.count(from: 0.0, to: CGFloat(activeUser.publicRepos!), withDuration: 1.0)
            cell.lblNumberOfFollowers.count(from: 0.0, to: CGFloat(activeUser.followers!), withDuration: 1.0)
            cell.lblNumberOfGists.count(from: 0.0, to: CGFloat(activeUser.publicGists!), withDuration: 1.0)
            cell.lblNumberOfFollowing.count(from: 0.0, to: CGFloat(activeUser.following!), withDuration: 1.0)
        }
        else
        {
            cell.lblNumberOfGists.text = "\(activeUser.publicGists!)"
            cell.lblNumberOfRepos.text = "\(activeUser.publicRepos!)"
            cell.lblNumberOfFollowers.text = "\(activeUser.followers!)"
            cell.lblNumberOfFollowing.text = "\(activeUser.following!)"
        }
    }
    
    @objc func backBtnPressed(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
