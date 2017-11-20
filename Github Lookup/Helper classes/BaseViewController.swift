//
//  BaseViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLORS.APP_BACKGROUND
        hideNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setTabAttribs(){
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = COLORS.APP_BACKGROUND
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    func setNavAttribs()
    {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = COLORS.APP_BLUE
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
    
    @objc func backBtnPressed(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
