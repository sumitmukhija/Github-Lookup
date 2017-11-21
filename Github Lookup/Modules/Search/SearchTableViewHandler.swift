//
//  SearchOperationHandler.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as! SearchTableHeader
        return header
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text
        {
            if query.contains(" ")
            {
                Utility.showErrorMessage(msg: GEN_STRINGS.NO_SPC)
                return
            }
            if(!Utility.isInternetAvailable())
            {
                Utility.showErrorMessage(msg: GEN_STRINGS.NO_NET)
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
        let actionSheet = UIAlertController(title: "Select an action", message: "What would you like to do with \(activeUser.login!)'s profile", preferredStyle: .actionSheet)
        
        let bookmarkAction = UIAlertAction(title: "Bookmark", style: .default) { (action) in
            
        }
        
        let viewAction = UIAlertAction(title: "View", style: .default) { (action) in
            
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
    
    func configureCell(activeUser: User, cell: UserSearchTableViewCell)
    {
        cell.lblName.text = activeUser.name
        cell.lblCity.text = activeUser.location
        cell.lblEmail.text = activeUser.email
        cell.lblGitUsername.text = activeUser.login
        cell.lblOrganization.text = activeUser.company
        cell.lblLastUpdated.text = "Last activity: \(activeUser.updatedAt!))"
        if activeUser.avatarUrl != GEN_STRINGS.NO_URL
        {
            let url = URL(string:activeUser.avatarUrl)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            cell.imgAvatar.image = image
        }
        cell.lblNumberOfGists.text = "\(activeUser.publicGists!)"
        cell.lblNumberOfFollowers.text = "\(activeUser.followers!)"
        cell.lblNumberOfRepos.text = "\(activeUser.publicRepos!)"
        cell.lblNumberOfFollowing.text = "\(activeUser.following!)"
    }
}
