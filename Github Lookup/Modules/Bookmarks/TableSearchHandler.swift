//
//  TableSearchHandler.swift
//  Github Lookup
//
//  Created by Sumit on 11/22/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

extension BookmarksViewController
{
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let activeUser = (isSearchActive == false ? dataSource[indexPath.row] : filteredArray[indexPath.row])
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: IDENTIFIERS.PROFILE_VIEW_CONTROLLER) as! ProfileViewController
        UserDefaultsHelper.addViewedCount()
        profileViewController.user = activeUser
        profileViewController.shouldGetImage = true
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.SEARCH_TABLE_CELL) as! UserSearchTableViewCell
        let activeUser = (isSearchActive == false ? dataSource[indexPath.row] : filteredArray[indexPath.row])
        configureCell(activeUser: activeUser, cell: cell, isLocalSearch: true)
        return cell
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isSearchActive == true ? filteredArray.count : dataSource.count)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = true
        if(searchText.characters.count == 0)
        {
            isSearchActive = false
        }
        else{
            filteredArray = dataSource.filter({ (user) -> Bool in
                if(user.login.lowercased().contains(searchText.lowercased()))
                {
                    return true
                }
                return false
            })
        }
        tableView.reloadData()
    }
}
