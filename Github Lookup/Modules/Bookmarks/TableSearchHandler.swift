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
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.SEARCH_TABLE_CELL) as! UserSearchTableViewCell
        let activeUser = dataSource[indexPath.row]
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
        filteredArray = dataSource.filter({ (user) -> Bool in
            if(user.login.contains(searchText))
            {
                return true
            }
            return false
        })
        tableView.reloadData()
    }
}
