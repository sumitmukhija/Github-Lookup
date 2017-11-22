//
//  SearchOperationHandler.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit
import UICountingLabel

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text
        {
            if query.contains(" ")
            {
                Utility.showErrorAlert(msg: GEN_STRINGS.NO_SPC)
                return
            }
            if(!Utility.isInternetAvailable())
            {
                Utility.showErrorAlert(msg: GEN_STRINGS.NO_NET)
                return
            }
            super.showHUD()
            ServerManager.getUserDetails(name: query, completion: { (err, usr) in
                super.hideHUD()
                if let _ = usr
                {
                    self.dataArray.removeAll()
                    if let _ = usr?.login
                    {
                        UserDefaultsHelper.addSearchCount()
                        CoreDataHelper.saveHistory(query: usr!.login!)
                        self.dataArray.append(usr!)
                        self.tableViewOutlet.reloadData()
                        self.tileCollectionView.reloadData()
                    }
                }
                else
                {
                    if let _ = err
                    {
                        Utility.showErrorAlert(code: err!.code)
                    }
                    self.dataArray.removeAll()
                    self.tableViewOutlet.reloadData()
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.SEARCH_TABLE_CELL) as! UserSearchTableViewCell
        let activeUser = dataArray[indexPath.row]
        configureCell(activeUser: activeUser, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let activeUser = dataArray[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! UserSearchTableViewCell
        let currentUserImage = cell.imgAvatar.image
        let actionSheet = UIAlertController(title: "Select an action", message: "What would you like to do with \(activeUser.login!)'s profile", preferredStyle: .actionSheet)
        
        let bookmarkAction = UIAlertAction(title: "Bookmark", style: .default) { (action) in
                CoreDataHelper.saveUser(user: activeUser, completion: { (isSuccess) in
                    if(isSuccess)!
                    {
                        Utility.showInfoAlert(msg: "\(activeUser.login!)'s profile successfully saved!")
                        self.tileCollectionView.reloadData()
                    }
                    else{
                        Utility.showErrorAlert(msg: "Couldn't bookmark \(activeUser.login!). Please try after some time")
                    }
                })
        }
        
        let viewAction = UIAlertAction(title: "View", style: .default) { (action) in
            let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: IDENTIFIERS.PROFILE_VIEW_CONTROLLER) as! ProfileViewController
            UserDefaultsHelper.addViewedCount()
            profileViewController.user = activeUser
            if let _ = currentUserImage
            {
                profileViewController.userImage = currentUserImage!
            }
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
            let content = "Hey! Check out \(activeUser.login!) on GitHub.\n\n\(activeUser.htmlUrl!)"
            super.share(message: content)
        }
        
        let cancelAction = UIAlertAction(title: "Dismiss", style: .destructive) { (action) in
            
        }
        actionSheet.addAction(viewAction)
        actionSheet.addAction(shareAction)
        actionSheet.addAction(bookmarkAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
