//
//  ViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func aboutBtnAction(_ sender: AnyObject) {
        Utility.showDisclaimerAlert(msg: "The application uses GitHub user API to search users on the basis of their login names. This application is a result of a hiring task by Cricbuzz. All the icons used are from Iconfinder.com")
    }
}

