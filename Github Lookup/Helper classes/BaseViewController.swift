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
    
    func showHUD()
    {
        if let _ = hud
        {
            hud!.textLabel.text = "git pull content.."
            hud!.show(in: self.view)
        }
    }
    
    func hideHUD()
    {
        if let _ = hud
        {
            hud!.dismiss(afterDelay: 1.0)
        }
    }
    
    @objc func backBtnPressed(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
