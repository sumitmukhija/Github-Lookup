//
//  SearchViewController.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

class SearchTableHeader: UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
}

class SearchViewController: BaseTabViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isSearchActive: Bool? = false
    var searchFilteredArray: [String] = []
    var dataArray: Array<User> = []
    let tilesTitle = ["\(TITLES.SEARCH)es", GEN_STRINGS.SAVED, GEN_STRINGS.VIEWED]
    let colors = [COLORS.MAT_CYAN, COLORS.MAT_TEAL, COLORS.MAT_AMBER]
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITLES.SEARCH
        initializeTileCollectionView()
        initializeSearchTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBarOutlet.becomeFirstResponder()
    }
    
    func initializeSearchTableView()
    {
        let nib = UINib(nibName: FILE_NAMES.SEARCH_TABLE_CELL, bundle: nil)
        tableViewOutlet.register(nib, forCellReuseIdentifier: IDENTIFIERS.SEARCH_TABLE_CELL)
        tableViewOutlet.showsVerticalScrollIndicator = false
        tableViewOutlet.separatorStyle = .none
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        searchBarOutlet.delegate = self
        searchBarOutlet.returnKeyType = .search
    }
    
    func initializeTileCollectionView()
    {
        let tileCellNib = UINib(nibName: FILE_NAMES.TILE_COLLECTION_CELL, bundle: nil)
        self.tileCollectionView.register(tileCellNib, forCellWithReuseIdentifier: IDENTIFIERS.TILE_COLLECTION_CELL)
        tileCollectionView.delegate = self
        tileCollectionView.dataSource = self
    }
}
