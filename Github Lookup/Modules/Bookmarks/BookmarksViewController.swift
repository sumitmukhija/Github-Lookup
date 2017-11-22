//
//  BookmarksViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class BookmarksViewController: BaseTabViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dataSource = Array<User>()
    var filteredArray = Array<User>()
    var isSearchActive: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TITLES.BOOKMARKS
        initTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        filteredArray.removeAll()
        dataSource.removeAll()
        isSearchActive = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showHUD(txt: "Pulling data from your iPhone")
        DispatchQueue.global(qos: .background).async {
            self.dataSource = CoreDataHelper.getAllLocalUsers()
            DispatchQueue.main.async {
                self.hideHUD()
                self.tableView.reloadData()
            }
        }
    }
    
    func initTableView(){
        let nib = UINib(nibName: FILE_NAMES.SEARCH_TABLE_CELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: IDENTIFIERS.SEARCH_TABLE_CELL)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .search
    }

}
